require "yaml"

module Drowsier
  class Config
    class ConfigFile
      include YAML::Serializable

      @[YAML::Field(key: "lockdown_start_at")]
      property lockdown_start_at_str : String

      @[YAML::Field(key: "lockdown_end_at")]
      property lockdown_end_at_str : String

      @[YAML::Field(key: "lock_screen")]
      property lock_screen : Bool

      @[YAML::Field(key: "check_interval_seconds")]
      property check_interval_seconds : Int32

      @[YAML::Field(key: "align_to_interval")]
      property align_to_interval : Bool

      @[YAML::Field(key: "force_screen_off_seconds")]
      property force_screen_off_seconds : Int32

      @[YAML::Field(key: "turn_on_screen_after_forced_off_period")]
      property turn_on_screen_after_forced_off_period : Bool

      @[YAML::Field(key: "lock_screen_command")]
      property lock_screen_command : String

      @[YAML::Field(key: "check_if_screen_is_off_command")]
      property check_if_screen_is_off_command : String

      @[YAML::Field(key: "turn_off_screen_command")]
      property turn_off_screen_command : String

      @[YAML::Field(key: "turn_on_screen_command")]
      property turn_on_screen_command : String

      @[YAML::Field(key: "pause_media_command")]
      property pause_media_command : String

      @[YAML::Field(key: "play_audio_notification_command")]
      property play_audio_notification_command : String

      @[YAML::Field(key: "system_startup_readiness_check_command")]
      property system_startup_readiness_check_command : String

      @[YAML::Field(key: "display_ansi_time_for_tty")]
      property display_ansi_time_for_tty : Bool

      @[YAML::Field(key: "lockdown_override_codes")]
      property lockdown_override_codes : Array(String)
    end

    def initialize(config_file_path : String)
      @config_file = ConfigFile.from_yaml(File.read(config_file_path))
    end

    def lockdown_start_at
      DatelessTime.from_string(config_file.lockdown_start_at_str)
    end

    def lockdown_end_at
      DatelessTime.from_string(config_file.lockdown_end_at_str)
    end

    def to_s
      [
        "lockdown start: " + lockdown_start_at.to_s,
        "lockdown end:   " + lockdown_end_at.to_s,
      ].join("\n")
    end

    private getter config_file

    delegate \
      lock_screen,
      check_interval_seconds,
      align_to_interval,
      force_screen_off_seconds,
      turn_on_screen_after_forced_off_period,
      lock_screen_command,
      check_if_screen_is_off_command,
      turn_off_screen_command,
      turn_on_screen_command,
      pause_media_command,
      play_audio_notification_command,
      system_startup_readiness_check_command,
      display_ansi_time_for_tty,
      lockdown_override_codes,
      to: config_file
  end
end
