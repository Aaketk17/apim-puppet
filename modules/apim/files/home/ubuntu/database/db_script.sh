#!/bin/bash

mysql -h apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com -u apimadmin -p'kj#$r435%7df' < /home/ubuntu/database/sql_commands_$1.txt
echo "DB dscripts updated successfully !!!"
if [ "$2" == "true" ]; then
    mysql -h apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com -u apimadmin -p'kj#$r435%7df' < /home/ubuntu/database/table_creation_commands.txt
else
    echo "Second argument is not 'true' or not provided. Tables creation command will not run"
fi