module Drowsier
  class AnsiTime
    def self.render(time : Time) : String
      output = IO::Memory.new
      time_svg_file_filled = File.tempfile("time-filled", ".svg") do |tempfile|
        time_svg_filled = self.time_svg_template(time: time.to_s("%l:%M %p"))
        tempfile.print(time_svg_filled)
      end
      Process.new(image2ascii_command(path: time_svg_file_filled.path), shell: true, output: output, error: output).wait
      time_svg_file_filled.delete
      output.to_s
    rescue
      "Error - could not generate ANSI time"
    end

    def self.image2ascii_command(path : String)
      "CLICOLOR_FORCE=1 TERM=blah /usr/bin/rbenv exec image2ascii '#{path}' --block --width 112"
    end

    def self.time_svg_template(time : String) : String
      <<-SVG
        <svg width="290" height="58" version="1.1" viewBox="0 0 290 58" xmlns="http://www.w3.org/2000/svg">
          <rect width="100%" height="100%" fill="#000000" />
          <text fill="#ffffff" font-family="Arial Black" font-size="58px">
            <tspan x="0" y="50">#{time}</tspan>
          </text>
        </svg>
        SVG
    end
  end
end
