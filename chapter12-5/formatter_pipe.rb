require 'fluent/plugin/formatter'

module Fluent::Plugin
  class PipeFormatter < Formatter
    Fluent::Plugin.register_formatter('pipe', self)

    def format(tag, time, record)
      values = []
      num_keys = record.keys.select{|k| k =~ /^\d+$/}
      num_keys.sort_by{|k| k.to_i}.each do |key|
        values << record[key]
      end
      values.join("|") + "\n"
    end
  end
end
