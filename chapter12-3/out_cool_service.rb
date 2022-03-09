require "fluent/plugin/output"

module Fluent::Plugin
  class CoolServiceOutput < Output
    Fluent::Plugin.register_output('cool_service', self)

    def format(tag, time, record)
      obj = {
        "tag" => tag,
        "time" => time.to_f,
        "record" => record,
      }
      JSON.dump(obj) + "\n"
    end

    def write(chunk)
      return if chunk.empty?
      send_to_somewhere(chunk.read)
      # あるいは書き込み先へのIOオブジェクトがあるなら
      # chunk.write_to(@myclient.io)
    end

    def send_to_somewhere(data)
      log.debug "sending a data", data: data
      # ここに、外部にデータをまとめて送信するコードを記述する
    end
  end
end
