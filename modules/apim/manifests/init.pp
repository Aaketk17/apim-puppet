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

# Class: apim
# Init class of API Manager default profile
class apim inherits apim::params {

  include apim_common

  # Copy configuration changes to the installed directory
  $template_list.each |String $template| {
    file { "${carbon_home}/${template}":
      ensure  => file,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb"),
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Copy files to carbon home directory
  $file_list.each | String $file | {
    file { "${carbon_home}/${file}":
      ensure => present,
      owner => $user,
      recurse => remote,
      group => $user_group,
      mode => '0755',
      source => "puppet:///modules/${module_name}/${file}",
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Copy files to home directory
  $file_list.each | String $file | {
    file { "/${file}":
      ensure => present,
      owner => $user,
      recurse => remote,
      group => $user_group,
      mode => '0755',
      source => "puppet:///modules/${module_name}/${file}",
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }

    # Exec resource to run the keytool command
    exec { "import_certificate_to_cts":
      command => "/opt/java/bin/keytool -import -alias apim-alias -file cert.crt -keystore /mnt/apim/wso2am-4.2.0/repository/resources/security/client-truststore.jks -storepass wso2carbon",
      path    => ['/usr/bin', '/bin', '/opt/java/bin'],
      refreshonly => true,
      require => File["/${file}"]
    }
  }

  file { "/home/ubuntu":
    ensure => present,
    owner => $user,
    recurse => remote,
    group => $user_group,
    mode => '0755',
    source => "puppet:///modules/${module_name}/u2-update.sh",
    notify  => Service["${wso2_service_name}"],
    require => Class["apim_common"]
  }

  exec { "run-u2-updates":
      command => "cd mnt/apim/wso2am-4.2.0/bin/ && ./wso2update_linux",
      refreshonly => true,
      notify  => Service["${wso2_service_name}"],
      require => File["/home/ubuntu"]
  }

  # Delete files to carbon home directory
  $file_removelist.each | String $removefile | {
    file { "${carbon_home}/${removefile}":
      ensure => absent,
      owner => $user,
      group => $user_group,
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Copy api-manager.sh to installed directory
  file { "${carbon_home}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb"),
    notify  => Service["${wso2_service_name}"],
    require => Class["apim_common"]
  }
  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> apim -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
