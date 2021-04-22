#!/bin/bash

>inventory     #just making empty inventory file
for component in frontend catalogue cart user shipping payment mysql mongo rabbitmq redis;do
     IP=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${component} Name=instance-state-name,Values=running | jq \
     '.Reservations[].Instances[].PrivateIpAddress')
     if [ -n "${IP}" ];then
       echo ${component}
       echo $IP component=${component} >>inventory
     fi
done
