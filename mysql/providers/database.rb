action :bootstrap do
  bash "bootstraping database:#{new_resource.database} with user:#{new_resource.username}" do
    query = <<-MYSQL_CODE
      CREATE DATABASE IF NOT EXISTS #{new_resource.database};
      GRANT ALL PRIVILEGES ON #{new_resource.database}.*
      TO #{new_resource.username}@'#{new_resource.host}' IDENTIFIED BY '#{new_resource.password}';
      GRANT FILE ON *.* TO #{new_resource.username}@'#{new_resource.host}';
      FLUSH PRIVILEGES;
    MYSQL_CODE
    cmd = <<-BASH_CODE
      mysql -uroot -p#{node.mysql.server_root_password} -e "#{query}"
    BASH_CODE
    code cmd
  end
end

action :grant do
  bash "bootstraping database:#{new_resource.database} with user:#{new_resource.username}" do
    query = <<-MYSQL_CODE
      GRANT ALL PRIVILEGES ON #{new_resource.database}.* TO #{new_resource.username}@'#{new_resource.host}' IDENTIFIED BY '#{new_resource.password}';
      GRANT FILE ON *.* TO #{new_resource.username}@'#{new_resource.host}';
      GRANT SUPER ON *.* TO #{new_resource.username}@'#{new_resource.host}' IDENTIFIED BY '#{new_resource.password}';
      FLUSH PRIVILEGES;
    MYSQL_CODE
    cmd = <<-BASH_CODE
      mysql -uroot -p#{node.mysql.server_root_password} -e "#{query}"
    BASH_CODE
    code cmd
  end
end
