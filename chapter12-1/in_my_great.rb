require "fluent/plugin/input"

module Fluent::Plugin
  class MyGreatInput < Input
    Fluent::Plugin.register_input('my_great', self)

    helpers :timer

    config_param :tag, :string, default: "my.great.events"
    config_param :interval, :time, default: 10 # デフォルトで10秒ごとに実行

    def start
      super

      timer_execute(:my_great_input, @interval) do
        # このブロック内の処理が定期的に呼び出される

        array = call_http_and_get_array()
        #=> [[time,record],[time,record], ...]

        router.emit_array(@tag, array)
      end
    end

    def call_http_and_get_array
      # HTTPリクエストを実行、結果を解析して日時、レコードのペアの配列を返す
      [[Fluent::EventTime.now, {"num" => 1}]]
    end
  end
end
