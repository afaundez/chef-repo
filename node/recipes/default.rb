execute 'cd /tmp && wget http://nodejs.tchol.org/repocfg/el/nodejs-stable-release.noarch.rpm'
execute 'yum localinstall -y --nogpgcheck /tmp/nodejs-stable-release.noarch.rpm'
execute 'yum install -y nodejs-compat-symlinks npm'