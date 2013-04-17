# How to

- Install rbenv:

```
rbenv_source 'install rbenv for some_user' do
  user 'some_user'
  action :install
end
```

- Install some ruby:

```
rbenv_ruby 'install ruby 1.9.3-p194 with rbenv for some_user' do
  user 'vagrant'
  version '1.9.3-p194'
  action :install
end
```

- Install a gem:

```
rbenv_gem 'install bundler to ruby 1.9.3-p194 installed with rbenv for some_user' do
  user 'vagrant'
  ruby_version '1.9.3-p194'
  gem_name 'bundler'
  action :install
end
```
