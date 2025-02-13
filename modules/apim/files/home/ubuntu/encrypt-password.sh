#!/usr/bin/expect -f

spawn sh /mnt/apim/wso2am-4.2.0/bin/ciphertool.sh -Dconfigure
expect "Please Enter Primary KeyStore Password of Carbon Server :"
send "wso2carbon\r"
interact

sleep 5
