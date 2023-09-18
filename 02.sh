
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


#Create a cluster
gcloud config set dataproc/region $REGION
gcloud dataproc clusters create example-cluster  --num-workers 2 \
  --master-machine-type e2-standard-2 \
  --worker-machine-type e2-standard-2 \
  --worker-boot-disk-size 100  

#copy file
#gsutil cp gs://cloud-training/gsp323/data.txt /data.txt

echo "" 
echo "Run this on one of the compute engine instances for cluster"
echo "hdfs dfs -cp gs://cloud-training/gsp323/data.txt /data.txt"
echo " "
echo "Then run 02-1.sh"

#gcloud dataproc jobs submit spark --cluster example-cluster \
#  --max-failures-per-hour=1 \
#  --class org.apache.spark.examples.SparkPageRank \
#  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- "/data.txt"


#POST /v1/projects/qwiklabs-gcp-04-a488da724a4b/regions/us-central1/jobs:submit/
#{
#  "projectId": "qwiklabs-gcp-04-a488da724a4b",
#  "job": {
#    "placement": {
##      "clusterName": "example-cluster"
#    },
#    "statusHistory": [],
#    "reference": {
#      "jobId": "job-b2fcac1d",
#      "projectId": "qwiklabs-gcp-04-a488da724a4b"
#    },
#    "scheduling": {
#O      "maxFailuresPerHour": "1"
#    },
#    "sparkJob": {
##      "mainClass": "org.apache.spark.examples.SparkPageRank",
#      "properties": {},
##      "jarFileUris": [
#        "file:///usr/lib/spark/examples/jars/spark-examples.jar"
#      ],
#      "args": [
#O        "/data.txt"
#      ]
#    }
#  }
#}
