require "./drowsier/config"
require "./drowsier/dateless_time"
require "./drowsier/dateless_time_period"
require "./drowsier/system"
require "./drowsier/watcher"

config_path = ENV.fetch("CONFIG") { ENV.fetch("HOME") + "/.config/drowsier/config.yaml" }
config = Drowsier::Config.new(config_path)
watcher = Drowsier::Watcher.new(config)

if ARGV.fetch(0, nil) == "--tty"
  watcher.tty
else
  watcher.run
end
