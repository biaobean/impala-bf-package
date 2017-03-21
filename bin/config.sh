rm -rf $BRANCH_BF_ROOT_DIR/conf
mkdir $BRANCH_BF_ROOT_DIR/conf
cp /opt/cloudera/parcels/CDH/lib/hive/conf/* $BRANCH_BF_ROOT_DIR/conf

rm -rf $BRANCH_BF_ROOT_DIR/incubator-impala/fe/src/test/resources
ln -s $BRANCH_BF_ROOT_DIR/conf $BRANCH_BF_ROOT_DIR/incubator-impala/fe/src/test/resources
