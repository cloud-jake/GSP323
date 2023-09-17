
#!/bin/bash
# Task 2: Run a simple Dataproc job

source variables.inc

#Job type	Spark
#Main class or jar	org.apache.spark.examples.SparkPageRank
#Jar files	file:///usr/lib/spark/examples/jars/spark-examples.jar
#Arguments	/data.txt
#Max restarts per hour	1
#Dataproc Cluster	Compute Engine
#Region	$REGION
#Machine Series	E2
#Manager Node	Set Machine Type to e2-standard-2
#Worker Node	Set Machine Type to e2-standard-2
#Max Worker Nodes	2

#copy file
#gsutil cp gs://cloud-training/gsp323/data.txt /data.txt

# Run this on one of the compute engine instances for cluster
#hdfs dfs -cp gs://cloud-training/gsp323/data.txt /data.txt

#Create a cluster
gcloud config set dataproc/region $REGION
gcloud dataproc clusters create example-cluster  --num-workers 2 \
  --master-machine-type e2-standard-2 \
  --worker-machine-type e2-standard-2   

gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPageRank \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000


