#!/bin/sh

cd $BRANCH_BF_ROOT_DIR/spark
git pull
## git log

cd $BRANCH_BF_ROOT_DIR/incubator-impala
git pull
## git log

cd $BRANCH_BF_ROOT_DIR/parquet-format
git pull
## git log

cd $BRANCH_BF_ROOT_DIR/parquet-mr
git pull

$BRANCH_BF_ROOT_DIR/impala-bf-package/bin/build.sh
