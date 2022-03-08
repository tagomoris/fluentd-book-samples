require "fluent/plugin/input"

module Fluent::Plugin
  class MySampleInput < Input
    Fluent::Plugin.register_input('my_sample', self)

    helpers :timer

    config_param :data, :string
    config_param :sample_interval, :time, default: 5

    def start
      super

      counter = 1
      timer_execute(:my_sample_timer, sample_interval) do
        router.emit(
          "test.my_sample",
          Fluent::EventTime.now,
          {"data" => data, "sequence" => counter}
        )
        counter += 1
      end
    end
  end
end
