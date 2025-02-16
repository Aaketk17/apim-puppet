#!/usr/bin/expect -f

# Access the environment variables
set email $env(EMAIL)
set password $env(PASSWORD)
spawn /mnt/apim/wso2am-4.2.0/bin/wso2update_linux
expect "Email:"
send "$email\r"
expect "Password for $email:"
send "$password\r"
sleep 5
interact