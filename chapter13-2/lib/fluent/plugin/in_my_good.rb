require "fluent/plugin/input"

module Fluent::Plugin
  class MyGoodInput < Input
    Fluent::Plugin.register_input('my_good', self)

    helpers :timer

    config_param :tag, :string
    config_param :interval, :time

    def start
      super
      timer_execute(:my_good_input_timer, @interval) do
        router.emit(@tag, Fluent::EventTime.now, {"data" => 1})
      end
    end
  end
end
