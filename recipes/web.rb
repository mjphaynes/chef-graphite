
python_pip "django" do
  version '1.3'
  action :install
end

python_pip "python-memcached"
python_pip "django-tagging" do
  version '0.3.1'
  action :install
end

%w{ pycairo-devel pycairo python-devel python-memcached python-rrdtool mod_wsgi }.each do |pkg|
  package pkg do
    action :install
  end
end

python_pip "graphite-web" do
  version "0.9.9"
  action :install
end

template "#{node['graphite']['base_dir']}/conf/graphite.wsgi" do
  source "graphite.wsgi.erb"
  owner node['apache']['user']
  group node['apache']['group']
end

template "#{node['apache']['dir']}/sites-available/graphite" do
  source "graphite-vhost.conf.erb"
  variables(:user => node['apache']['user'],
            :group => node['apache']['group'] )
end

apache_site "graphite"

apache_site "000-default" do
  enable false
end

directory "#{node['graphite']['storage_dir']}/log/webapp" do
  owner node['apache']['user']
  group node['apache']['group']
  recursive true
end

%w{ info.log exception.log access.log error.log }.each do |file|
  file "#{node['graphite']['storage_dir']}/log/webapp/#{file}" do
    owner node['apache']['user']
    group node['apache']['group']
  end
end

template "#{node['graphite']['doc_root']}/graphite/local_settings.py" do
  source "local_settings.py.erb"
  mode 00755
  variables(:timezone => node['graphite']['timezone'],
            :base_dir => node['graphite']['base_dir'],
            :doc_root => node['graphite']['doc_root'],
            :storage_dir => node['graphite']['storage_dir'],
            :memcache_hosts => node['graphite']['memcache_hosts'])
end

template "#{node['graphite']['base_dir']}/bin/set_admin_passwd.py" do
  source "set_admin_passwd.py.erb"
  mode 00755
end

cookbook_file "#{node['graphite']['storage_dir']}/graphite.db" do
  action :create_if_missing
  notifies :run, "execute[set admin password]"
end

# The graphite.db file already contains the table setup
# execute "initial database creation" do
#   command "python manage.py syncdb --noinput"
#   cwd "#{node['graphite']['doc_root']}/graphite"
#   action :nothing
# end

execute "set admin password" do
  command "#{node['graphite']['base_dir']}/bin/set_admin_passwd.py root #{node['graphite']['password']}"
  action :nothing
end

# This is not done in the cookbook_file above to avoid triggering a password set on permissions changes
file "#{node['graphite']['storage_dir']}/graphite.db" do
  owner node['apache']['user']
  group node['apache']['group']
  mode 00644
end
