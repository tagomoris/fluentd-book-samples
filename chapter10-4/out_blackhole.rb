require "fluent/plugin/output"

module Fluent::Plugin
  class BlackholeOutput < Output
    Fluent::Plugin.register_output('blackhole', self)

    def multi_workers_ready?
      true
    end

    def write(chunk)
      # Throw the chunk to the blackhole!
    end
  end
end
