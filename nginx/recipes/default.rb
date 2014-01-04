apt_repository 'nginx' do
  uri 'http://ppa.launchpad.net/nginx/stable/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
  action :add
end

package 'nginx'
execute 'rm -fv /etc/nginx/sites-enabled/default'
service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
