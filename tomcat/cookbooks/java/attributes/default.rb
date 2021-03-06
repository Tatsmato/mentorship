#
# Author:: Seth Chisamore (<schisamo@chef.io>)
# Cookbook:: java
# Attributes:: default
#
# Copyright:: 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# default jdk attributes
default['java']['jdk_version'] = '7'
default['java']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i586'
default['java']['openjdk_packages'] = []
default['java']['openjdk_version'] = nil
default['java']['accept_license_agreement'] = false
default['java']['set_default'] = true
default['java']['alternatives_priority'] = 1062
default['java']['set_etc_environment'] = false
default['java']['use_alt_suffix'] = true
default['java']['reset_alternatives'] = true

# the following retry parameters apply when downloading oracle java
default['java']['ark_retries'] = 0
default['java']['ark_retry_delay'] = 2
default['java']['ark_timeout'] = 600
default['java']['ark_download_timeout'] = 600

case node['platform_family']
when 'windows'
  default['java']['install_flavor'] = 'windows'
  default['java']['windows']['url'] = nil
  default['java']['windows']['checksum'] = nil
  default['java']['windows']['package_name'] = 'Java(TM) SE Development Kit 7 (64-bit)'
  default['java']['windows']['public_jre_home'] = nil
  default['java']['windows']['owner'] = 'administrator'
  default['java']['windows']['remove_obsolete'] = false
when 'mac_os_x'
  default['java']['install_flavor'] = 'homebrew'
else
  default['java']['install_flavor'] = 'openjdk'
end

# S390(X) - IBM zSeries Architecture - only IBM jre / jdk can be used. Download from https://developer.ibm.com/javasdk/downloads/
if node['kernel']['machine'].start_with?('s390')
  default['java']['install_flavor'] = 'ibm'
end

default['java']['ibm']['url'] = nil
default['java']['ibm']['checksum'] = nil
default['java']['ibm']['accept_ibm_download_terms'] = false

default['java']['ibm']['6']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck HtmlConverter idlj jar jarsigner
                                             java javac javadoc javah javap javaws jconsole jcontrol jdb jdmpview
                                             jrunscript keytool native2ascii policytool rmic rmid rmiregistry
                                             schemagen serialver tnameserv wsgen wsimport xjc)

default['java']['ibm']['7']['bin_cmds'] = node['java']['ibm']['6']['bin_cmds'] + %w(pack200 unpack200)
default['java']['ibm']['8']['bin_cmds'] = node['java']['ibm']['7']['bin_cmds']

# type of java RPM : jdk or jre
default['java']['oracle_rpm']['type'] = 'jdk'

# optional, can be overriden to pin to a version different
# from the up-to-date.
default['java']['oracle_rpm']['package_version'] = nil

# optional, some distros re-package the official Oracle's RPM
# with a different name
default['java']['oracle_rpm']['package_name'] = nil

# if you change this to true, you can download directly from Oracle
default['java']['oracle']['accept_oracle_download_terms'] = false

# direct download paths for oracle, you have been warned!

# jdk6 attributes
default['java']['jdk']['6']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck HtmlConverter idlj jar jarsigner
                                             java javac javadoc javah javap javaws jconsole jcontrol jdb jhat
                                             jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd jvisualvm
                                             keytool native2ascii orbd pack200 policytool rmic rmid rmiregistry
                                             schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc)

# x86_64
default['java']['jdk']['6']['x86_64']['url'] = 'http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin'
default['java']['jdk']['6']['x86_64']['checksum'] = '6b493aeab16c940cae9e3d07ad2a5c5684fb49cf06c5d44c400c7993db0d12e8'

# i586
default['java']['jdk']['6']['i586']['url'] = 'http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-i586.bin'
default['java']['jdk']['6']['i586']['checksum'] = 'd53b5a2518d80e1d95565f0adda54eee229dc5f4a1d1a3c2f7bf5045b168a357'

# jdk7 attributes

default['java']['jdk']['7']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck idlj jar jarsigner java javac
                                             javadoc javafxpackager javah javap javaws jcmd jconsole jcontrol jdb
                                             jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd jvisualvm
                                             keytool native2ascii orbd pack200 policytool rmic rmid rmiregistry
                                             schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc)

# Oracle doesn't seem to publish SHA256 checksums for Java releases, so we use MD5 instead.
# Official checksums for the latest release can be found at https://www.oracle.com/webfolder/s/digest/7u75checksum.html

# x86_64
default['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz'
default['java']['jdk']['7']['x86_64']['checksum'] = '6f1f81030a34f7a9c987f8b68a24d139'

# i586
default['java']['jdk']['7']['i586']['url'] = 'http://download.oracle.com/otn/java/jdk/7u75-b13/jdk-7u75-linux-i586.tar.gz'
default['java']['jdk']['7']['i586']['checksum'] = 'e4371a4fddc049eca3bfef293d812b8e'

# jdk8 attributes

default['java']['jdk']['8']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck idlj jar jarsigner java javac
                                             javadoc javafxpackager javah javap javaws jcmd jconsole jcontrol jdb
                                             jdeps jhat jinfo jjs jmap jmc jps jrunscript jsadebugd jstack
                                             jstat jstatd jvisualvm keytool native2ascii orbd pack200 policytool
                                             rmic rmid rmiregistry schemagen serialver servertool tnameserv
                                             unpack200 wsgen wsimport xjc)

# Official checksums for the latest release can be found at https://www.oracle.com/webfolder/s/digest/8u172checksum.html

# x86_64
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346'

# i586
default['java']['jdk']['8']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-i586.tar.gz'
default['java']['jdk']['8']['i586']['checksum'] = '0a4310d31246924d5c3cd161b9da7f446acef373e6484452c80de8d8519f5a33'

default['java']['oracle']['jce']['enabled'] = false
default['java']['oracle']['jce']['8']['url'] = 'https://edelivery.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip'
default['java']['oracle']['jce']['8']['checksum'] = 'f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59'
default['java']['oracle']['jce']['7']['url'] = 'http://ORACLE_HAS_REMOVED_THESE_FILES.SELF_HOST_THEM_INSTEAD'
default['java']['oracle']['jce']['7']['checksum'] = 'CALCULATE_THIS_FROM_YOUR_FILE'
default['java']['oracle']['jce']['6']['url'] = 'http://ORACLE_HAS_REMOVED_THESE_FILES.SELF_HOST_THEM_INSTEAD'
default['java']['oracle']['jce']['6']['checksum'] = 'CALCULATE_THIS_FROM_YOUR_FILE'
default['java']['oracle']['jce']['home'] = '/opt/java_jce'
