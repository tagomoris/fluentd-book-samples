require "fluent/plugin/input"

module Fluent::Plugin
  class AdditionalCheckInput < Input
    Fluent::Plugin.register_input('additional_check', self)

    config_param :myparam, :string

    def configure(conf)
      super
      # superのあとにパラメータの値が取得できるようになる
      if myparam.size < 16 || myparam.size > 32
        raise Fluent::ConfigError, "Parameter 'myparam' must be 16-32 chars"
      end
    end
  end
end
