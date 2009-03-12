require 'yaml'
puts "Loading pagify configuration..."

path = "#{RAILS_ROOT}/config/pagify.yml"
APP_CONFIG = YAML.load_file(path)