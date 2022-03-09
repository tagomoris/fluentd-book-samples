require 'json'

class MyProtocolServer
  def self.create(port, &block)
    MyProtocolServer.new(port: port, &block)
  end

  def initialize(port:, interval: 2, &block)
    @interval = interval
    @port = port
    @block = block
    @running = false
  end

  def start
    @running = true
    while @running
      sleep @interval
      break unless @running
      @block.call({interval: @interval, port: @port, tag: "my.protocol.data"}.to_json)
    end
  end

  def stop
    @running = false
  end
end
