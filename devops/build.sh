#!/bin/sh

set -e

ecr=$(echo `aws ecr describe-repositories --profile wsrodgerss --repository-names sam-cloud-one-ecr --query 'repositories[0].repositoryUri' || aws ecr create-repository --profile wsrodgerss --repository-name sam-cloud-one-ecr --query 'repository.repositoryUri'` | tr -d '"')

registry=$(echo `aws sts get-caller-identity --profile wsrodgerss --query 'Account'` | tr -d '"')

echo "ecr registry - $registry"
echo "ecr url - $ecr"

aws ecr get-login-password --profile wsrodgerss --region us-east-1 | docker login --username AWS --password-stdin ${registry}.dkr.ecr.us-east-1.amazonaws.com

docker build hello-world -t sam-cloud-one-function:v2
docker tag sam-cloud-one-function:v2 ${ecr}:v2
docker push ${ecr}:v2

echo "sam-cloud-one-function:v2 image pushed to ${ecr}:v2"
