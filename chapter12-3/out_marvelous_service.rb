require "fluent/plugin/output"

module Fluent::Plugin
  class MarvelousServiceOutput < Output
    Fluent::Plugin.register_output('marvelous_service', self)

    def write(chunk)
      return if chunk.empty?
      array = []
      chunk.each do |time, record| # timeはEventTime、recordはHash
        obj = {
          "time" => time.to_i,
          "nano_sec" => time.nsec,
          "record" => record,
        }
        array << obj
      end
      send_to_somewhere(JSON.dump(array))
    end

    def send_to_somewhere(json_text)
      log.debug "sending a JSON data", json: json_text
      # ここに、外部にデータをまとめて送信するコードを記述する
    end
  end
end
