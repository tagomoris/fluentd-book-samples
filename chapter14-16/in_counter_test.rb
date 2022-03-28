require 'fluent/plugin/input'

module Fluent::Plugin
  class CounterTestInput < Input
    Fluent::Plugin.register_input("counter_test", self)

    helpers :counter, :timer

    config_param :run_interval, :time, default: 5

    def start
      super
      @counter = counter_client_create(scope: "counter_test")

      result = @counter.init(
        [
          {name: 'records', value: 0, reset_interval: 0},
          {name: 'size', value: 0, reset_interval: 86400}
        ]
      ).get
      if result.error?
        log.debug("Counter initialization error", error: result.errors)
      end

      timer_execute(:counter_test_loop, @run_interval) do
        a = @counter.get('records', 'size').get
        pp(here: :a, a: a)

        v = @counter.inc([{name: 'records', value: 1}, {name: 'size', value: 1}]).get
        pp(here: :v, v: v)

        r1 = @counter.reset('records').get
        pp(here: :r1, r: r1)
        r2 = @counter.reset('size').get
        pp(here: :r2, r: r2)

        # d = @counter.delete('records', 'size').get
        # pp(here: :d, d: d)
      end
    end
  end
end
