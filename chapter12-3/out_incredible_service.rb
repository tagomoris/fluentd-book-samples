require "fluent/plugin/output"

module Fluent::Plugin
  class IncredibleServiceOutput < Output
    Fluent::Plugin.register_output('incredible_service', self)

    # エラーストリームを使用する場合にはこのヘルパーが必要
    helpers :event_emitter

    def format(tag, time, record)
      if ! record.has_key?("number")
        # 仮に、numberフィールドがない場合は不正データだとする
        raise "Unexpected data, without the key 'number'"
      end
      obj = {"tag" => tag, "time" => time.to_f, "record" => record}
      JSON.dump(obj) + "\n"
    rescue => e
      log.error("Failed to dump events into JSON", error: e)
      router.emit_error_event(tag, time, record, e) # エラーストリームへ出力
      # formatからnilを返すと処理対象から除外される
      nil
    end

    def write(chunk)
      return if chunk.empty?
      send_to_somewhere(chunk.read)
    end

    def send_to_somewhere(data)
      log.debug "sending a data", data: data
      # ここに、外部にdataを送信するコードを記述
    end
  end
end
