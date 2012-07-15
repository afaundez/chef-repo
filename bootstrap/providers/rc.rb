action :setup do
  cookbook_file "/home/#{new_resource.user}/.gemrc" do
    cookbook 'bootstrap'
    source 'gemrc'
    owner new_resource.user
    group new_resource.user
    mode 0644
  end

  cookbook_file "/home/#{new_resource.user}/.irbrc" do
    cookbook 'bootstrap'
    source 'irbrc'
    owner new_resource.user
    group new_resource.user
    mode 0644
  end

  cookbook_file "/home/#{new_resource.user}/.gitconfig" do
    cookbook 'bootstrap'
    source 'gitconfig'
    owner new_resource.user
    group new_resource.user
    mode 0644
  end
end
