git clone https://github.com/biaobean/impala-bf-package
source impala-bf-package/bin/set.sh
sh impala-bf-package/bin/checkout_projects.sh
git clone https://github.com/cloudera/native-toolchain
cd native-toolchain
./buildall.sh
cd ..

ln -s $PWD/native-toolchain/build $PWD/incubator-impala/toolchain
sh impala-bf-package/bin/build.sh

source incubator-impala/bin/impala-config.sh
./start-impala-cluster.py -s 1

sh impala-bf-package/bin/test.sh
