###
# Check package
###
ls -l $BRANCH_BF_ROOT_DIR/parquet-format/target/parquet-format-2.3.1-SNAPSHOT.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-format/2.3.1-SNAPSHOT/parquet-format-2.3.1-SNAPSHOT.jar

ls -l $BRANCH_BF_ROOT_DIR/parquet-mr/parquet-tools/target/parquet-tools-1.8.2-SNAPSHOT.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT.jar

ls -l $BRANCH_BF_ROOT_DIR//parquet-mr/parquet-tools/dependency-reduced-pom.xml
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT.pom

ls -l $BRANCH_BF_ROOT_DIR/parquet-mr/parquet-tools/target/parquet-tools-1.8.2-SNAPSHOT-tests.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT-tests.jar

###
# Generate BF Parquet File
###

export OUTPUT_DIR=/tmp/bf_parq
rm -rf $OUTPUT_DIR
rm /tmp/out.log

cat $BRANCH_BF_ROOT_DIR/script/test_bf.scala | $BRANCH_BF_ROOT_DIR/spark/bin/spark-shell 1>/tmp/out.log 2>&1


grep -q "Bloom filter is enabled" /tmp/out.log && echo "Bloom filter is enabled" || echo "[ERROR]:Bloom filter is NOT enabled"

###
# Create Impala table
###

rm $OUTPUT_DIR/_SUCCESS
export M_FILE=`cd $OUTPUT_DIR; ls part-r-00007*`

sudo -u hdfs hadoop fs -rmr /data/bf_parq
sudo -u hdfs hadoop fs -put $OUTPUT_DIR /data

IMPALA_SHELL=$BRANCH_BF_ROOT_DIR/incubator-impala/bin/impala-shell.sh

# $IMPALA_SHELL -q "DROP TABLE bf_real_data;"
# $IMPALA_SHELL -q "CREATE EXTERNAL TABLE bf_real_data LIKE PARQUET '/data/bf_parq/$M_FILE' STORED AS PARQUET LOCATION '/data/bf_parq';"

###
# Run Impala Test
###
select * from bf_real_data where record_id = '1233024271'
