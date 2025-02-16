#!/bin/bash

mysql -h apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com -u apimadmin -p'kj#$r435%7df' < /home/ubuntu/database/sql_commands_$1.txt
echo "DB dscripts updated successfully !!!"