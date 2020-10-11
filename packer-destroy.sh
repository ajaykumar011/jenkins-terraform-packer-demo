#!/bin/bash -xe
aws ec2 deregister-image --image-id $(<this-ami.txt)
aws ec2 delete-snapshot --snapshot-id $(<this-ami.txt)