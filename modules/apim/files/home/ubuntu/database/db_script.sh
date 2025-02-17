#!/bin/bash

mysql -h apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com -u apimadmin -p'kj23rtr4357df' < /home/ubuntu/database/sql_commands_$1.txt
echo "user creation scripts updated successfully !!!"
if [ "$2" == "true" ]; then
    mysql -h apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com -u apimadmin -p'kj23rtr4357df' < /home/ubuntu/database/table_creation_commands.txt
    echo "table creation scripts updated successfully !!!"
else
    echo "Second argument is not 'true' or not provided. Tables creation command will not run"
fi