require "./drowsier/config"
require "./drowsier/dateless_time"
require "./drowsier/dateless_time_period"
require "./drowsier/system"
require "./drowsier/watcher"

config_path = ENV.fetch("CONFIG", "config.yaml")
config = Drowsier::Config.from_yaml(File.read(config_path))
Drowsier::Watcher.new(config).run
