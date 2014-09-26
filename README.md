# Jibu Database Schema 项目 [![Build Status](https://travis-ci.org/gaixie/jibu-schema.svg?branch=master)](https://travis-ci.org/gaixie/jibu-schema)

## PostgreSQL 数据库配置

$ sudo su -l postgres
$ cd ./jibu-schema/postgresql

### 使用 postgres 用户创建库及数据库用户
$ psql -U postgres
postgres> CREATE USER jibu_db_user WITH PASSWORD '000000';
postgres> CREATE DATABASE jibu_db OWNER jibu_db_user ENCODING 'UTF8';
postgres> \q

### 开始创建 schema
$ ./sc-modify.sh

### 初始化数据
$ psql -U jibu_db_user -d jibu_db -1 < data/data00.sql