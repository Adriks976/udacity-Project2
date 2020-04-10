#!/bin/bash

action=$1
stack=$2

if [[ "$action" =~ ^(create|update)$ ]]; then
    echo "You will perform $action for stack $stack"

    if [[ "$stack" =~ ^(secure)$ ]]; then
        IP_local=`curl -s https://ipinfo.io/ip`
        aws ssm put-parameter --name 'SourceCidrIp' --value ${IP_local}'/32' --type String --overwrite 
        ssh-keygen -t rsa -b 4096 -f udagramKey -C "My Udagram key" -N '' -q
        aws ec2 import-key-pair --key-name "udagramKey" --public-key-material fileb://./udagramKey.pub
        aws ssm put-parameter --name 'udagramKey' --value "$(cat udagramKey.pub)" --type SecureString --overwrite
        echo "Done"
        exit
    fi

    aws cloudformation ${action}-stack \
        --stack-name $2 \
        --template-body file://stacks/$2.yml \
        --parameters file://parameters/$2.json \
        --region=eu-west-1 \
        --capabilities CAPABILITY_NAMED_IAM
    
    echo "Done"
    exit

elif [[ "$action" =~ ^(delete)$ ]]; then
    echo "You will perform $action for stack $stack"

    if [[ "$stack" =~ ^(secure)$ ]]; then
        aws ssm delete-parameter --name 'SourceCidrIp'
        aws ec2 delete-key-pair --key-name "udagramKey"
        aws ssm delete-parameter --name 'udagramKey'
        rm udagramKey*
        echo "Done"
        exit
    fi

    aws cloudformation ${action}-stack \
    --stack-name $2 \
    --region=eu-west-1
    echo "Done"
    exit
else
    echo "Not a valid action"
    exit
fi
