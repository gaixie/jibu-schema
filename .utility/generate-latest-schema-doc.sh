#!/bin/bash
#
# DISCRIPTION: 通过 travis-ci 自动生成数据库 schema 并发布到 github pages.
# see http://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/ for details

if [ "$TRAVIS_REPO_SLUG" == "gaixie/jibu-schema" ] && \
    [ "$TRAVIS_PULL_REQUEST" == "false" ]; then

    echo -e "Publishing schema doc...\n"

    java -jar $SPYPATH -t pgsql -host localhost -db jibu_db -s public -u jibu_db_user -p 000000 -dp $JDBCPATH -charset UTF-8 -o $HOME/schema-latest 

    cd $HOME
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "travis-ci"
    git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/gaixie/sandbox gh-pages > /dev/null

    cd gh-pages

    if [ "$TRAVIS_BRANCH" == "master" ]; then
        git rm -rf ./schema-doc/latest
        mkdir -p ./schema-doc
        cp -Rf $HOME/schema-latest ./schema-doc/latest
    else
        git rm -rf ./schema-doc/snapshot
        mkdir -p ./schema-doc
        cp -Rf $HOME/schema-latest ./schema-doc/snapshot
    fi

    git add -f .
    git commit -m "Lastest schema doc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
    git push -fq origin gh-pages > /dev/null

    echo -e "Published Schema Doc to gh-pages.\n"
fi
