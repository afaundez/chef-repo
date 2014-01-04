action :run do
  bash "execute #{new_resource.name}" do
    cmd = <<-BASH_CODE
      mysql -u#{new_resource.user} -p#{new_resource.password} -h#{new_resource.host} -e "#{new_resource.command}"
    BASH_CODE
    code cmd
  end
end
