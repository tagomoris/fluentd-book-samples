require "fluent/plugin/filter"

module Fluent::Plugin
  class MyFirstFilter < Filter
    Fluent::Plugin.register_filter('my_first', self)

    def filter(tag, time, record)
      return record
    end
  end
end
