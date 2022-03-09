require "fluent/plugin/output"
require "my_service"

module Fluent::Plugin
  class MyServiceOutput < Output
    Fluent::Plugin.register_output('my_service', self)

    config_param :endpoint, :string, \
      desc: "Endpoint URI starting with https://..."

    def configure(conf)
      super
      raise Fluent::ConfigError, "Use https:// endpoint" unless endpoint.start_with?("https://")
    end

    def start
      super # 呼ぶのを忘れないこと

      @client = MyService.new(endpoint)
    end

    def write(chunk)
      # chunkからデータを読み、相手サービスに合うようデータ形式を整える
      data = build_data(chunk.read)
      @client.send(data)
    end

    def build_data(data)
      # この例ではとりあえず文字列化だけする
      data.to_s
    end
  end
end
