default['graphite']['version']        = "0.9.10"
default['graphite']['password']       = "change_me"
default['graphite']['url']            = "graphite"
default['graphite']['url_aliases']    = []
default['graphite']['listen_port']    = 80
default['graphite']['base_dir']       = "/opt/graphite"
default['graphite']['doc_root']       = "/opt/graphite/webapp"
default['graphite']['storage_dir']    = "/opt/graphite/storage"
default['graphite']['timezone']       = "Europe/London"
default['graphite']['memcache_hosts'] = []
default['graphite']['django_root']    = "@DJANGO_ROOT@"

default['graphite']['carbon']['line_receiver_interface']   = "0.0.0.0"
default['graphite']['carbon']['line_receiver_port']        = 2003
default['graphite']['carbon']['pickle_receiver_interface'] = "0.0.0.0"
default['graphite']['carbon']['pickle_receiver_port']      = 2004
default['graphite']['carbon']['cache_query_interface']     = "0.0.0.0"
default['graphite']['carbon']['cache_query_port']          = 7002
default['graphite']['carbon']['max_cache_size']            = "inf"
default['graphite']['carbon']['max_creates_per_second']    = "inf"
default['graphite']['carbon']['max_updates_per_second']    = "1000"
default['graphite']['carbon']['service_type']              = "init"
default['graphite']['carbon']['log_whisper_updates']       = "False"