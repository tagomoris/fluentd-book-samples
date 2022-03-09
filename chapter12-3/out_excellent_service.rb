require "fluent/plugin/output"

module Fluent::Plugin
  class ExcellentServiceOutput < Output
    Fluent::Plugin.register_output('excellent_service', self)

    def write(chunk)
      # どこにも出力しないで破棄する
    end
  end
end
