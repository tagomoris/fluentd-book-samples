require 'fluent/plugin/formatter'

module Fluent::Plugin
  class PipeFormatter < Formatter
    Fluent::Plugin.register_formatter('pipe', self)

    def format(tag, time, record)
      values = []
      num_keys = record.keys.select{|k| k =~ /^\d+$/}.map{|n| n.to_i}
      num_keys.sort.each do |num|
        values << record[num.to_s]
      end
      values.join("|") + "\n"
    end
  end
end
