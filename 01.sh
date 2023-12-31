#!/bin/bash
# Task 1: Run a simple Dataflow job

source variables.inc

gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com


UDF_PATH="gs://cloud-training/gsp323/lab.js"
JSON_PATH="gs://cloud-training/gsp323/lab.schema"
#JSON_PATH="gs://bq-jake--skillsboost/lab.schema.fixed"
UDF_NAME="transform"
GCS_INPUT="gs://cloud-training/gsp323/lab.csv"
MACHINE_TYPE="e2-standard-2"

#Create a BigQuery dataset called BigQuery Dataset Name.
bq mk ${BQ_DATASET}

bq mk \
 --table \
 --description "This is my table" \
 ${BQ_OUTPUT} \
 lab.schema.fixed

#Create a Cloud Storage Bucket called Cloud Storage Bucket Name.
gsutil mb gs://$GCS_BUCKET

#Create Dataflow Job
#Text Files on Cloud Storage to BigQuery 

gcloud dataflow jobs run GSP323 \
    --gcs-location gs://dataflow-templates-${REGION}/latest/GCS_Text_to_BigQuery \
    --region ${REGION} \
    --worker-machine-type="e2-standard-2"\
    --staging-location $TEMP \
    --parameters \
javascriptTextTransformGcsPath=${UDF_PATH},\
javascriptTextTransformFunctionName=${UDF_NAME},\
JSONPath=${JSON_PATH},\
inputFilePattern=${GCS_INPUT},\
outputTable=${BQ_OUTPUT},\
bigQueryLoadingTemporaryDirectory=${TEMP}