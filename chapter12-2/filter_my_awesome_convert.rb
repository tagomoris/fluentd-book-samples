require "fluent/plugin/filter" # これでFluent::Plugin::Filterを参照

module Fluent::Plugin
  class MyAwesomeConvertFilter < Filter
    Fluent::Plugin.register_filter('my_awesome_convert', self)

    def filter(tag, time, record)
      record
    end
  end
end
