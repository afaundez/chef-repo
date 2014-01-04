#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2010, James Harton <james@sociable.co.nz>
#
# Apache 2.0 License.
#


if ['debian','ubuntu'].member? node[:platform]
  # Make sure it's installed. It would be a pretty broken system
  # that didn't have it.
  package "tzdata" do
    action :upgrade
  end

  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end

elsif ['rhel','centos','scientific','amazon'].member? node[:platform]

  require 'chef/util/file_edit'
  package 'tzdata'

  link '/etc/localtime' do
    to "/usr/share/zoneinfo/#{node[:tz]}"
  end

  clock = Chef::Util::FileEdit.new("/etc/sysconfig/clock")
  clock.search_file_replace_line(/^ZONE=.*$/, "ZONE=\"#{node[:tz]}\"")
  clock.write_file
end