#!/bin/bash
#
# SCRIPT:  schemaspy.sh
# PURPOSE: 生成当前数据库 Schema 文档，输出到 output 目录，该目录不做版本控制，直接上传至开发服务器的文档区
# DISCRIPTION: 先 checkout schemaspy的源码并编译 
#              svn co https://schemaspy.svn.sourceforge.net/svnroot/schemaspy schemaspy
#              cd schemaspy/trunk
#              mvn install

# 得到执行脚本文件的当前目录，如果文件是个软链接，需要通过 readlink 来处理
# 注意：下面的代码段不能在 Mac OS 下正常工作
PRG="$0"

while [ -h $PRG ]; do
    PRG=$(readlink $PRG) 
done

PRGDIR=$(cd -P "$(dirname $PRG)" && pwd)

# 加载全局共用变量文件 scripts/COMM_VARS
. $PRGDIR/COMM_VARS

SPYPATH="$HOME/.m2/repository/net/sourceforge/schemaspy/schemaspy/5.0.0/schemaspy-5.0.0.jar"
JDBCPATH="$HOME/.m2/repository/postgresql/postgresql/9.1-901.jdbc4/postgresql-9.1-901.jdbc4.jar"

DBPASS="000000"

VER=$(psql -h $DBHOST -d $DBNAME -U $DBUSER -t -c "SELECT 'v'||major||'.'||minor||'.'||revision FROM schema_changes ORDER BY major DESC, minor DESC, revision DESC LIMIT 1")

if [[ -z $VER ]]
then
    java -jar $SPYPATH -t pgsql -host $DBHOST -db $DBNAME -s public -u $DBUSER -p $DBPASS -dp $JDBCPATH -charset UTF-8 -o output 
else
    java -jar $SPYPATH -t pgsql -host $DBHOST -db $DBNAME -s public -u $DBUSER -p $DBPASS -dp $JDBCPATH -desc $VER -charset UTF-8 -o output 
fi

