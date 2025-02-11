#!/usr/bin/expect -f
spawn /mnt/apim/wso2am-4.2.0/bin/wso2update_linux
expect "Email:"
send "athavan@wso2.com\r"
expect "Password for athavan@wso2.com:"
send "gabtow-5Wuvky-wemxeq\r"
interact