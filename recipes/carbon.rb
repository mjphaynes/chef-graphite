
python_pip "carbon" do
  version '0.9.9'
  action :install
end

template "/etc/init.d/carbon-cache" do
  source "carbon-cache.init.erb"
  variables(
    :dir  => node['graphite']['base_dir'],
    :user => node['apache']['user']
  )
  mode 00744
end

template "#{node['graphite']['base_dir']}/conf/carbon.conf" do
  owner node['apache']['user']
  group node['apache']['group']
  variables( :line_receiver_interface => node['graphite']['carbon']['line_receiver_interface'],
             :line_receiver_port => node['graphite']['carbon']['line_receiver_port'],
             :pickle_receiver_interface => node['graphite']['carbon']['pickle_receiver_interface'],
             :pickle_receiver_port => node['graphite']['carbon']['pickle_receiver_port'],
             :cache_query_interface => node['graphite']['carbon']['cache_query_interface'],
             :cache_query_port => node['graphite']['carbon']['cache_query_port'],
             :max_cache_size => node['graphite']['carbon']['max_cache_size'],
             :max_updates_per_second => node['graphite']['carbon']['max_updates_per_second'],
             :max_creates_per_second => node['graphite']['carbon']['max_creates_per_second'],
             :log_whisper_updates => node['graphite']['carbon']['log_whisper_updates'],
             :storage_dir => node['graphite']['storage_dir'])
  notifies :restart, "service[carbon-cache]"
end

template "#{node['graphite']['base_dir']}/conf/storage-schemas.conf" do
  owner node['apache']['user']
  group node['apache']['group']
end

template "#{node['graphite']['base_dir']}/conf/storage-aggregation.conf" do
  owner node['apache']['user']
  group node['apache']['group']
end

directory node['graphite']['storage_dir'] do
  owner node['apache']['user']
  group node['apache']['group']
  recursive true
end

%w{ log whisper }.each do |dir|
  directory "#{node['graphite']['storage_dir']}/#{dir}" do
    owner node['apache']['user']
    group node['apache']['group']
  end
end

service "carbon-cache" do
  action [:enable, :start]
end
