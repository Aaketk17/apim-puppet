# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
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

# Class: apim::custom
# This class is reserved to run custom user code before starting the server.
class apim::custom inherits apim::params {
  if $facts['ec2_metadata']['tags']['instance']['Node'] == 'One' {
    mysql_user { "apdimdbuser@apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com":
      ensure => present,
      password_hash => mysql_password("kj#$r435%7df"),
      require => Package[mysql],
    }
    mysql_grant { "apdimdbuser@apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com/apim_db":
      privileges => "all",
      require => Mysql_user["apdimdbuser@pim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com"],
    }
    mysql::db { 'apim_db':
      user     => 'apdimadmin',
      password => 'kj#$r435%7df',
      host     => 'apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com',
      sql      => ['/home/ubuntu/apim_db.sql'],
      grant    => ['ALL'],
      charset  => 'latin1', 
      collate  => 'latin1_swedish_ci',
    }

    # mysql::db { 'shared_db':
    #   user     => 'shareddbuser',
    #   password => 'kj#$r435%7df',
    #   host     => 'apim-mysql-db.cgk7myovdx4l.ap-south-1.rds.amazonaws.com',
    #   sql      => ['/home/ubuntu/shared_db.sql'],
    #   grant    => ['ALL'],
    #   charset  => 'latin1', 
    #   collate  => 'latin1_swedish_ci',
    # }
  }
}
