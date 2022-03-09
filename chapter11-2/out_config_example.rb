require "fluent/plugin/output"

module Fluent::Plugin
  class ConfigExampleOutput < Output
    Fluent::Plugin.register_output('config_example', self)

    config_param :name, :string

    def start
      super
      log.info "Configured name is #{name} (or #{@name})"
    end

    def write(chunk)
      # 全イベントを破棄
    end
  end
end
