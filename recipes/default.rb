include_recipe "python"
include_recipe "apache2"

include_recipe "graphite::carbon"
include_recipe "graphite::whisper"
include_recipe "graphite::web"
