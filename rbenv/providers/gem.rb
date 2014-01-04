action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"
  gem_version = (new_resource.gem_version.empty?) ? '' : "-v=#{new_resource.gem_version}"
  source_url = (new_resource.source.nil? or new_resource.source.empty?) ? '' : "--source #{new_resource.source}"
  exid = Time.now.to_i

  bash "install #{new_resource.gem_name} gem for ruby #{new_resource.ruby_version} with rbenv for user #{new_resource.user}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "mkdir /tmp/#{exid} && cd /tmp/#{exid} && rbenv local #{new_resource.ruby_version} && cd /tmp/#{exid} && rbenv exec gem install #{gem_version} #{new_resource.gem_name} #{source_url} && rbenv rehash && rm -f /tmp/#{exid}/.rbenv-version"
    environment  ({'HOME' => user_root})
    not_if "ls -R #{user_root}/.rbenv | grep '/gems/#{new_resource.gem_name}-#{new_resource.gem_version}'"
  end

end

action :update do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"

  bash "update rubygems for ruby #{new_resource.ruby_version} with rbenv for user #{new_resource.user}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "mkdir /tmp/#{exid} && cd /tmp/#{exid} && rbenv local #{new_resource.ruby_version} && cd /tmp/#{exid} && rbenv exec gem update --system '#{new_resource.rubygems_version}' && rbenv rehash && rm -f /tmp/#{exid}/.rbenv-version"
    environment  ({'HOME' => user_root})
    not_if "ls -R #{user_root}/.rbenv | grep /gems/rubygems-update-#{new_resource.rubygems_version}/"
  end

end