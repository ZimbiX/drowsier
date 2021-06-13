require "./drowsier/config"
require "./drowsier/dateless_time"
require "./drowsier/dateless_time_period"
require "./drowsier/system"
require "./drowsier/watcher"

config_path = ENV.fetch("CONFIG") { ENV.fetch("HOME") + "/.config/drowsier/config.yaml" }
config = Drowsier::Config.new(config_path)
silent = ARGV.includes?("--silent")
watcher = Drowsier::Watcher.new(config, silent)

if ARGV.includes?("--tty")
  watcher.tty
else
  watcher.run
end
