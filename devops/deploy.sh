#!/bin/sh

case "$1" in

  sync)

    # builds function use docker metadata
    # uploads function image to ECR and sets the image uri
    sam sync \
      --profile wsrodgerss \
      --stack-name sam-cloud-one-stack \
      --template-file template.yaml \
      --image-repositories HelloWorldFunction=780041187732.dkr.ecr.us-east-1.amazonaws.com/sam-cloud-one-ecr \
      --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM CAPABILITY_IAM
    rm -rf .aws-sam
    ;;

  *)

    # expects function image to be built and pushed to ECR
    # expects function to have and ECR image uri
    sam deploy \
      --profile wsrodgerss \
      --stack-name sam-cloud-one-stack \
      --template-file template.yaml \
      --resolve-s3 \
      --image-repositories HelloWorldFunction=780041187732.dkr.ecr.us-east-1.amazonaws.com/sam-cloud-one-ecr \
      --capabilities CAPABILITY_IAM
    ;;

esac
