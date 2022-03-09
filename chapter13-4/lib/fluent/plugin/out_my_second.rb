require "fluent/plugin/output"
require "second_service"

module Fluent::Plugin
  class MySecondOutput < Output
    Fluent::Plugin.register_output('my_second', self)

    attr_accessor :client

    config_param :username, :string
    config_param :apikey, :string, secret: true
    config_param :timestamp_key_name, :string, default: 'timestamp'

    def configure(conf)
      super
      @client = SecondService::Client.new
    end

    def write(chunk)
      @data = []
      chunk.each do |time, record|
        @data << record.merge({@timestamp_key_name => time.to_f})
      end
      @client.transmit(@username, @apikey, @data)
    end
  end
end
