#!/bin/bash
echo "Generating traffic against app"
times=$1
for (( i = 0; i <= $times; i++ )) 
do 
  echo "Request number $i"
  res=$(curl -s -k 'GET' 'http://localhost:4010')
  echo $res
  sleep 3s
done