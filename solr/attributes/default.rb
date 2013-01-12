default[:solr][:user] = 'solr'
default[:solr][:version] = '4.0.0'
default[:solr][:url] = "http://apache.mesi.com.ar/lucene/solr/#{node[:solr][:version]}/apache-solr-#{node[:solr][:version]}.tgz"
default[:solr][:home] = '/var/solr-standalone'
default[:solr][:instances] = [{:port => 8983, :type => :multicore}]
default[:solr][:min_memory] = 1024
default[:solr][:max_memory] = 2048