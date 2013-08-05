actions :install, :update
attribute :user, :kind_of => String, :required => true
attribute :ruby_version, :kind_of => String, :required => true
attribute :gem_name, :kind_of => String
attribute :gem_version, :kind_of => String, :default => ''
attribute :rubygems_version, :kind_of => String
attribute :source, :kind_of => String
