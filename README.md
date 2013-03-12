# Graphite

## Description

Installs and configures [Graphite](http://graphite.wikidot.com/). 
Much of the work in this cookbook is done by [Heavy Water Software](https://github.com/heavywater/chef-graphite) and [Hector Castro](https://github.com/hectcastro/chef-graphite).
This version is configured specifically for Amazon Linux as I couldn't get any others to work out of the box on the Amazon AMIs.
This can be integrated into the great [StatsD](https://github.com/etsy/statsd) library from [Etsy](http://etsy.com) for realtime statistics. 

## Requirements

### Platforms

* Amazon Linux

### Cookbooks

* apache2
* python

## Attributes

* `node['graphite']['version']` - version of graphite to install (defaults to 0.9.10)
* `node['graphite']['password']` - password for graphite root user(defaults to `change_me`)
* `node['graphite']['url']` - url of the graphite server (defaults to graphite)
* `node['graphite']['url_aliases']` - array of url aliases (defaults to nil)
* `node['graphite']['listen_port']` - port to listen on (defaults to 80)
* `node['graphite']['base_dir']` = "/opt/graphite"
* `node['graphite']['doc_root']` = "/opt/graphite/webapp"
* `node['graphite']['storage_dir']` = "/opt/graphite/storage"
* `node['graphite']['django_root']` = "@DJANGO_ROOT@" - configurable path to your django installation
* `node['graphite']['timezone']` - Set the timezone for the graphite web interface, defaults to Europe/London
* `node['graphite']['memcache_hosts']` - Array of IP and port pairs for memcached.
* `node['graphite']['carbon']['line_receiver_interface']` - line interface IP (defaults to 0.0.0.0)
* `node['graphite']['carbon']['line_receiver_port']` - line interface port (defaults to 2003)
* `node['graphite']['carbon']['pickle_receiver_interface']` - pickle receiver IP (defaults to 0.0.0.0)
* `node['graphite']['carbon']['pickle_receiver_port']` - pickle receiver port (defaults to 2004)
* `node['graphite']['carbon']['cache_query_interface']` - cache query IP (defaults to 0.0.0.0)
* `node['graphite']['carbon']['cache_query_port']` - cache query port (defaults to 7002)
* `node['graphite']['carbon']['max_cache_size']` - max size of the carbon cache (defaults to "inf")
* `node['graphite']['carbon']['max_creates_per_second']` - max number of new metrics to create per second (defaults to "inf")
* `node['graphite']['carbon']['max_updates_per_second']` - max updates to carbon per second (defaults to "1000")
* `node['graphite']['carbon']['service_type']` - init service to use for carbon (defaults to runit)
* `node['graphite']['carbon']['log_whisper_updates']` - log updates to whisper (defaults to false)

## Recipes

* `recipe[graphite]` will install Graphite and all of its components.
* `recipe[graphite::carbon]` will install Carbon.
* `recipe[graphite::whisper]` will install Whisper.
* `recipe[graphite::web]` will install Graphite's dashboard.

## Usage

`recipe[graphite]` should build a stand-alone Graphite installation on Amazon Linux.

Graphite's credentials default to username `root` and password `change_me` (customisable) 
with an e-mail address going no where.  Also, two schemas are provided by default:
`stats.*` for [StatsD](https://github.com/etsy/statsd) and a catchall that matches anything.