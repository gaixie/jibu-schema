#!/bin/bash
#
# SCRIPT:  sc-modify.sh
# PURPOSE: 通过脚本自动更新 Schema ，并维护 Schema 版本
# DISCRIPTION: 初次创建库时 FILENAME=baseline，以后的修改 FILENAME=changes
#              baseline 或者 changes 必须保证文件最后一行是空行，否则脚本执行会有问题

# 得到执行脚本文件的当前目录，如果文件是个软链接，需要通过 readlink 来处理
# 注意：下面的代码段不能在 Mac OS 下正常工作
PRG="$0"

while [ -h $PRG ]; do
    PRG=$(readlink $PRG) 
done

PRGDIR=$(cd -P "$(dirname $PRG)" && pwd)

# 加载全局共用变量文件 scripts/COMM_VARS
. $PRGDIR/COMM_VARS

FILENAME=../baseline
count=0
ver=
VERSQL=
SCRIPTS=

while read LINE
do
    if [ $count -eq 0 ] && [[ $LINE == VERSION* ]]  
    then
        # 将 VERSION=x.y.z 做split ，得到 $ver=x.y.z
        ver=`echo $LINE| cut -d'=' -f 2`
        if [[ -z "$ver" ]]
        then
            exit
        else
            # split $ver ,得到 $1=x, $2=y, $3=z
            # 取得 git 当前的 commit hash，保存到 schema_changes 表的 hash字段
            IFS=.
            set -- $ver
            VERSQL="INSERT INTO schema_changes (major, minor, revision, hash) VALUES ($1,$2,$3,'$(git rev-parse HEAD)');"
            unset IFS
        fi
    else
        let count++
        SCRIPTS="$SCRIPTS $LINE "
    fi
done < $FILENAME

# 先将所有要修改的语句合并为一个 sc.x.y.z.log文件
# 通过 psql 在一个事务中执行该文件，最后取得更新后的 schema 版本
# 全部处理完以后，删除 sc.x.y.z.log 文件。
if [[ -z "$VERSQL" ]] && [[ -z "$SCRIPTS" ]]
then
    echo "Schema modify failed!"    
else
    echo "Schema modify scripts($count) is:\n $SCRIPTS \n" 
    echo "Schema version sql is:\n $VERSQL \n" 
    echo '\encoding utf8' > sc.$ver.log
    cat $SCRIPTS >> sc.$ver.log
    # 如果导入一个生产环境的库，需要让 schema_changes_id_seq 前进一位
    echo "SELECT nextval('schema_changes_id_seq');" >> sc.$ver.log
    echo $VERSQL >> sc.$ver.log
    $PGHOME/bin/psql -h $DBHOST -d $DBNAME -U $DBUSER -W -1 -f sc.$ver.log
    echo "Current schema version is:" 
    $PGHOME/bin/psql -h $DBHOST -d $DBNAME -U $DBUSER -1 -c "SELECT * FROM schema_changes ORDER BY major DESC, minor DESC, revision DESC LIMIT 1"
    rm sc.$ver.log
fi
