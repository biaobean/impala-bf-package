#/bin/sh

git clone https://github.com/cjjnjust/spark.git
cd spark
git checkout parquet_bf
## git log

cd ..
git clone https://github.com/cjjnjust/incubator-impala
cd incubator-impala
git checkout parquet_bf
## git log

cd ..
git clone https://github.com/cjjnjust/parquet-format
cd parquet-format
git checkout parquet-41
## git log

cd ..
git clone https://github.com/cjjnjust/parquet-mr
cd parquet-mr
git checkout parquet-41
## git log
