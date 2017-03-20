import org.apache.spark.sql.SparkSession

sc.setLogLevel("DEBUG")

val spark: SparkSession = SparkSession.builder.master("local").config("spark.sql.parquet.enable.bloom.filter","true").config("spark.sql.parquet.bloom.filter.expected.entries","3100").config("spark.sql.parquet.bloom.filter.col.name","record_id").appName("2.1 rebase: Load parquet with bf").getOrCreate

val sqlDF = spark.sql("SELECT CAST(record_id AS STRING) record_id, cdr_id FROM parquet.`/home/ec2-user/data/b24d14ade0a4e0e9-d5c3b5e96e9bcb95_2035586954_data.9.parq`")

sqlDF.createOrReplaceTempView("tsample")

sql("SELECT record_id, cdr_id FROM tsample").write.parquet("/tmp/test.parq")

val bsqlDF = spark.sql("SELECT * FROM parquet.`/tmp/test.parq/part-r-00007-*.snappy.parquet`")

bsqlDF.createOrReplaceTempView("tbf")

sql("select * from tbf where record_id = '1233024271'").show

sql("explain select * from tbf where record_id = '1233024271'").show
