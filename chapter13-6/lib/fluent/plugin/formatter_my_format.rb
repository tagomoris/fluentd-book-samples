require "fluent/plugin/formatter"

module Fluent::Plugin
  class MyFormatFormatter < Formatter
    Fluent::Plugin.register_formatter("my_format", self)

    def format(tag, time, record)
      record.map{|k,v| "#{k}|#{v}"}.join(",") + "\n"
    end
  end
end
