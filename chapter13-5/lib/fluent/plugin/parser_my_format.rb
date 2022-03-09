require "fluent/plugin/parser"

module Fluent::Plugin
  class MyFormatParser < Parser
    Fluent::Plugin.register_parser('my_format', self)

    def parse(text)
      text.split("\n").each do |line|
        obj = {}
        line.split(",").each do |pair_text|
          key, value = pair_text.split("|", 2)
          obj[key] = value
        end
        time = parse_time(obj)
        yield time, obj
      end
    end
  end
end
