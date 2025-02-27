#----------------------------------------------------------------------------
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
#----------------------------------------------------------------------------

class apim_common::params {

  $packages = ["unzip","expect"]
  $version = "4.2.0"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "remote"
  # $pack_location = "local"
  $remote_jdk = "https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-17.0.14.7.1-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # ----- Profile configs -----
  case $profile {
    'apim_gateway': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_GATEWAY_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=gateway-worker"
    }
    'apim_control_plane': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_CONTROL_PLANE_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=control-plane"
    }
    'apim_tm': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_TRAFFICMANAGER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=traffic-manager"
    }
    default: {
      $pack = "wso2am-${version}"
      $remote_pack = "https://s3.ap-south-1.amazonaws.com/wso2-apim-v4.2.0/wso2am-4.2.0.zip"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = ""
    }
  }

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Server stop retry configs
  $try_count = 5
  $try_sleep = 5

  # ----- api-manager.xml config params -----
  $analytics_enabled = 'false'
  $analytics_config_endpoint = 'https://control.apim-wso2.com/auth/v1'
  $analytics_auth_token = ''

  $ai_enabled = 'false'
  $ai_endpoint = ''
  $ai_token = ''

  $gateway_environments = [
    {
      type                                  => 'hybrid',
      name                                  => 'Default',
      gateway_type                          => 'Regular',
      provider                              => 'wso2',
      description                           => 'This is a hybrid gateway that handles both production and sandbox token traffic.',
      server_url                            => 'https://gateway.apim-wso2.com/services/',
      ws_endpoint                           => 'ws://localhost:9099',
      wss_endpoint                          => 'wss://localhost:8099',
      http_endpoint                         => 'http://gateway.apim-wso2.com',
      https_endpoint                        => 'https://gateway.apim-wso2.com',
      websub_event_receiver_http_endpoint   => 'http://localhost:9021',
      websub_event_receiver_https_endpoint  => 'https://localhost:8021'
    }
  ]

  if $facts['ec2_metadata']['tags']['instance']['Node'] == 'One' {
    $event_duplicate_url = 'tcp://apim-node-2.example.com:5672'
    $throttle_decision_endpoints = 'tcp://apim-node-1.example.com:5672'
  } elsif $facts['ec2_metadata']['tags']['instance']['Node'] == 'Two' {
    $event_duplicate_url = 'tcp://apim-node-1.example.com:5672'
    $throttle_decision_endpoints = 'tcp://apim-node-2.example.com:5672'
  }

  $throttling_url_group = [
    {
      traffic_manager_urls      => 'tcp://apim-node-1.example.com:9611',
      traffic_manager_auth_urls => 'ssl://apim-node-1.example.com:9711'
    },
    {
      traffic_manager_urls      => 'tcp://apim-node-2.example.com:9611',
      traffic_manager_auth_urls => 'ssl://apim-node-2.example.com:9711'
    }
  ]

  $gateway_labels = ["Default"]

  $key_manager_server_url = 'https://control.apim-wso2.com/services/'
  $key_validator_thrift_server_host = 'control.apim-wso2.com'

  $api_devportal_url = 'https://control.apim-wso2.com/devportal'
  $throttle_service_url = 'https://control.apim-wso2.com/services/'

  $traffic_manager_receiver_url = 'tcp://${carbon.local.ip}:${receiver.url.port}'
  $traffic_manager_auth_url = 'ssl://${carbon.local.ip}:${auth.url.port}'

  # ----- Master-datasources config params -----
  $wso2_rds_host = 'apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com'
  
  $wso2am_db_url = 'jdbc:mysql://apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com:3306/apim_db?useSSL=false'
  $wso2am_db_username = 'apimdbadmin'
  $wso2am_db_password = 'rterg56jg357df'
  $wso2am_db_type = 'mysql'
  $wso2am_db_validation_query = 'SELECT 1'

  $wso2shared_db_url = 'jdbc:mysql://apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com:3306/shared_db?useSSL=false'
  $wso2shared_db_username = 'shareddbadmin'
  $wso2shared_db_password = 'bnguilui57df'
  $wso2shared_db_type = 'mysql'
  $wso2shared_db_validation_query = 'SELECT 1'


  # ----- Carbon.xml config params -----
  $ports_offset = 0

  $key_store_location = 'wso2carbon.jks'
  $analytics_key_store_location = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $key_store_password = 'wso2carbon'
  $key_store_key_alias = 'wso2carbon'
  $key_store_key_password = 'wso2carbon'

  $internal_keystore_location = 'wso2carbon.jks'
  $internal_keystore_password = 'wso2carbon'
  $internal_keystore_key_alias = 'wso2carbon'
  $internal_keystore_key_password = 'wso2carbon'

  $trust_store_location = 'client-truststore.jks'
  $analytics_trust_store_location = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $trust_store_password = 'wso2carbon'

  # ----- user-mgt.xml config params -----
  $admin_username = 'admin'
  $admin_password = 'admin'

  $event_listener_notification_endpoint = 'https://control.apim-wso2.com/internal/data/v1/notify'

  $token_exchange_enable = true
  $token_exchange_allow_refresh_tokens = true
  $token_exchange_iat_validity_period = '1h'

  $enable_u2_updaes = false
  $enable_db_updates = false
}

