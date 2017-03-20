#!/bin/sh

cd $BRANCH_BF_ROOT_DIR/parquet-format
mvn clean install -DskipTests

cd $BRANCH_BF_ROOT_DIR/parquet-mr
mvn clean install -DskipTests

cd $BRANCH_BF_ROOT_DIR/spark
rm spark-2.1.0-SNAPSHOT-bin-custom-spark.tgz
./build/mvn -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.0 -DskipTests clean package

./dev/make-distribution.sh --name custom-spark --tgz -Phadoop-2.6 -Pyarn

cd $BRANCH_BF_ROOT_DIR/incubator-impala
export IMPALA_HOME=`pwd`
source $IMPALA_HOME/bin/impala-config.sh
./buildall.sh -notests -build_shared_libs
