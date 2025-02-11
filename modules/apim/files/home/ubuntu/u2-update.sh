#!/usr/bin/expect -f

# Access the environment variables
# set email $env(EMAIL)
# set password $env(PASSWORD)
export JAVA_HOME='/opt/java'
spawn sh /mnt/apim/wso2am-4.2.0/bin/ciphertool.sh -Dconfigure
expect "Please Enter Primary KeyStore Password of Carbon Server :"
send "wso2carbon\r"
interact

# spawn /mnt/apim/wso2am-4.2.0/bin/wso2update_linux
# expect "Email:"
# send "$email\r"
# expect "Password for $email:"
# send "$password\r"
# interact