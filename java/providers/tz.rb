#
# Author:: Bryan W. Berry (<bryan.berry@gmail.com>)
# Cookbook Name:: java
# Provider:: ark
#
# Copyright 2011, Bryan w. Berry
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

action :update do

  source_url = new_resource.url
  java_bin = new_resource.java_bin

  remote_file ::File.join(Chef::Config[:file_cache_path], 'tzupdater.jar') do
    source source_url
    mode 0644
  end

  execute "#{java_bin} -jar tzupdater.jar -u -v" do
    cwd Chef::Config[:file_cache_path]
    returns [0, 1]
  end

end
