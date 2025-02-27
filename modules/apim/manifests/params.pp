# ----------------------------------------------------------------------------
#  Copyright (c) 2021 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

# Claas apim::params
# This class includes all the necessary parameters.
class apim::params inherits apim_common::params {

  $start_script_template = 'bin/api-manager.sh'
  $jvmxms = '1g'
  $jvmxmx = '2g'

  $template_list = [
    'repository/conf/deployment.toml'
  ]

  # Define file list
  $file_list = [
    'repository/components/lib',
  ]
  $home_file_list = [
    'home/ubuntu/apim'
  ]

  $u2_updates_files = 'home/ubuntu/u2-updates'
  $db_scripts_files = 'home/ubuntu/database'

  $password_file = 'encrypt'

  # Define remove file list
  $file_removelist = []
  $db_script_create = true
  $db_script_remove = false
  $enable_sql_scripts = "false"

  # ----- Carbon.xml config params -----
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'control.apim-wso2.com'

  # ----- api-manager.xml config params -----
  $oauth_configs_revoke_api_url = 'https://control.apim-wso2.com/oauth2/revoke'
  $throttle_config_policy_deployer_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
}
