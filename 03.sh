#!/bin/bash
#Task 3: Use the Google Cloud Speech API

source variables.inc

# API Key
# API Key
echo "Generate API KEY from console"

# file for request.json
# gs://cloud-training/gsp323/task3.flac

# Create your Speech API request

echo '
{
  "config": {
      "encoding":"FLAC",
      "languageCode": "en-US"
  },
  "audio": {
      "uri":"gs://cloud-training/gsp323/task3.flac"
  }
}' > request.json


curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json

# copy output to location
gsutil cp result.json ${SPEECH_PATH}

