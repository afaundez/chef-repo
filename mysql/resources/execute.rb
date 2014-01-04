actions :run

attribute :host, :kind_of => String, :default => 'localhost'
attribute :user, :kind_of => String, :default => 'root'
attribute :password, :kind_of => String, :default => 'root123'
attribute :command, :kind_of => String