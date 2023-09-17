#!/bin/bash
# Task 1: Run a simple Dataflow job

source variables.inc

gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com


UDF_PATH="gs://cloud-training/gsp323/lab.js"
JSON_PATH="gs://cloud-training/gsp323/lab.schema"
UDF_NAME="transform"
GCS_INPUT="gs://cloud-training/gsp323/lab.csv"
MACHINE_TYPE="e2-standard-2"

#Create a BigQuery dataset called BigQuery Dataset Name.
bq mk gs://${BQ_DATASET}

#Create a Cloud Storage Bucket called Cloud Storage Bucket Name.
gsutil mb $GCS_BUCKET

#Create Dataflow Job
#Text Files on Cloud Storage to BigQuery 

gcloud dataflow jobs run GSP323 \
    --gcs-location gs://dataflow-templates-${REGION}/latest/Stream_GCS_Text_to_BigQuery \
    --region ${REGION} \
    --staging-location STAGING_LOCATION \
    --parameters \
javascriptTextTransformGcsPath=${UDF_PATH},\
javascriptTextTransformFunctionName=${UDF_NAME},\
JSONPath=${JSON_PATH},\
inputFilePattern=${GCS_INPUT},\
outputTable=${BQ_OUTPUT},\
outputDeadletterTable=${BQ_TEMP},\
bigQueryLoadingTemporaryDirectory=${TEMP}
