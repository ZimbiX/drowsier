module Drowsier
  class Override
    def initialize(@config : Config)
    end

    def override? : Bool
      prompt_for_and_check_code_valid
    end

    private def prompt_for_and_check_code_valid : Bool
      entered_code = prompt_for_code
      config.lockdown_override_codes.includes?(entered_code)
        .tap { |is_valid| puts(is_valid ? "Code valid" : "Code invalid") }
    end

    private def prompt_for_code : String
      print "Enter a lockdown override code: "
      gets || ""
    end

    private getter config
  end
end
