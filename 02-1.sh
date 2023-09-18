
#!/bin/bash
# Task 2: Run a simple Dataproc job

source variables.inc

gcloud dataproc jobs submit spark --cluster example-cluster \
  --max-failures-per-hour=1 \
  --class org.apache.spark.examples.SparkPageRank \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- "/data.txt"


