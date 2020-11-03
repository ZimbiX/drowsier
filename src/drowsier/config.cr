require "yaml"

module Drowsier
  class Config
    include YAML::Serializable

    @[YAML::Field(key: "lockdown_start_at")]
    property lockdown_start_at_str : String

    @[YAML::Field(key: "lockdown_end_at")]
    property lockdown_end_at_str : String

    @[YAML::Field(key: "check_interval_seconds")]
    property check_interval_seconds : Int32

    @[YAML::Field(key: "force_screen_off_seconds")]
    property force_screen_off_seconds : Int32

    @[YAML::Field(key: "lock_screen_command")]
    property lock_screen_command : String

    @[YAML::Field(key: "check_if_screen_is_off_command")]
    property check_if_screen_is_off_command : String

    @[YAML::Field(key: "turn_off_screen_command")]
    property turn_off_screen_command : String

    @[YAML::Field(key: "pause_media_command")]
    property pause_media_command : String

    @[YAML::Field(key: "play_audio_notification_command")]
    property play_audio_notification_command : String

    def lockdown_start_at_time
      DatelessTime.from_string(lockdown_start_at_str)
    end

    def lockdown_end_at_time
      DatelessTime.from_string(lockdown_end_at_str)
    end

    def to_s
      [
        "lockdown start: " + lockdown_start_at_time.to_s,
        "lockdown end:   " + lockdown_end_at_time.to_s,
      ].join("\n")
    end
  end
end
