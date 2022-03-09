require "fluent/plugin/input"

# サーバライブラリMyProtocolServerを読み込む
require "my_protocol_server"

module Fluent::Plugin
  class MyServerInput < Input
    Fluent::Plugin.register_input('my_server', self)

    helpers :thread

    config_param :port, :integer, default: 8118

    def start
      super

      @server = MyProtocolServer.create(@port) do |data|
        tag, record = parse_data_and_get_a_tag_and_record(data)
        router.emit(tag, Fluent::EventTime.now, record)
      end
      thread_create(:my_server_input_thread) do
        @server.start # ここでブロックする
      end
    end

    def stop
      @server.stop
      super
    end

    def parse_data_and_get_a_tag_and_record(data)
      # 送信されてきたデータを解析してtagとrecordを取り出す
      record = JSON.parse(data)
      tag = record.delete("tag")
      return tag, record
    end
  end
end
