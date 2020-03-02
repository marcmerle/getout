# frozen_string_literal: true

module AnimationHelper
  def animate(frame_name, nb_frames, total_duration)
    frame_path = "#{frame_name}/#{frame_name}"

    values = (0...nb_frames).map do |i|
      image_path(frame_path + format('%03d', i) + '.svg')
    end

    <<~HTML
      <svg version="1.1" baseProfile="tiny" id="svg-root"
        width="100%" height="100%" viewBox="0 0 600 600"
        xmlns="http://www.w3.org/2000/svg":wrap_with
        xmlns:xlink="http://www.w3.org/1999/xlink">

        <image width="600" height="600" xlink:href="frame000.svg">
          <animate attributeName="xlink:href"
                  values="#{values.join(';')}"
                  begin="0s" repeatCount="indefinite" dur="#{total_duration}s"/>
        </image>
      </svg>
    HTML
  end
end
