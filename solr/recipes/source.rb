include_recipe 'java::oracle'

group node[:solr][:user]

user node[:solr][:user] do
  gid node[:solr][:user]
  shell '/bin/bash'
  home "/home/#{node[:solr][:user]}"
  supports :manage_home => true
end

version = node[:solr][:version]
unpacked_solr_dir = "/home/#{node[:solr][:user]}/apache-solr-#{version}"
# WARNING! THIS REMOVE THE GZ COMPRESSSION
remote_file "#{unpacked_solr_dir}.tar" do
  source node[:solr][:url]
  owner node[:solr][:user]
  group node[:solr][:user]
  mode 0644
  not_if {File.exists? "#{unpacked_solr_dir}.tar"}
end

bash "unpack solr #{unpacked_solr_dir}.tar" do
  cwd "/home/#{node[:solr][:user]}"
  user node[:solr][:user]
  code "tar xf #{unpacked_solr_dir}.tar"
  not_if "test -d #{unpacked_solr_dir}"
end

solr_instance_path = "/home/#{node[:solr][:user]}/solr-#{version}"
directory solr_instance_path do
  owner node[:solr][:user]
  group node[:solr][:user]
  mode 0755
  action :create
end

# Install each standalone solr
node[:solr][:instances].each do |instance|
  port = instance[:port] || default_instance[:port]
  solr_dir = "/home/#{node[:solr][:user]}/solr-#{version}"
  execute "cp -R #{unpacked_solr_dir}/example/* #{solr_dir}/s-#{port}" do
    not_if "test -d #{solr_dir}/s-#{port}"
  end

  if instance[:type] == :multicore
    directory "#{solr_dir}/s-#{port}/multicore/template_core/conf" do
      recursive true
    end

    cookbook_file "#{solr_dir}/s-#{port}/multicore/template_core/conf/solrconfig.xml" do
      source 'solrconfig.xml'
    end

    cookbook_file "#{solr_dir}/s-#{port}/multicore/template_core/conf/schema.xml" do
      source 'schema.xml'
    end

    cookbook_file "#{solr_dir}/s-#{port}/multicore/solr.xml" do
      source 'solr.xml'
      not_if "grep '<!-- chef-cookbook-file -->' #{solr_dir}/s-#{port}/multicore/solr.xml"
    end
  end

  execute "chown -R solr:solr #{solr_dir}"
end
