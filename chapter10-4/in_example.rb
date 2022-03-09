require "fluent/plugin/input"
require "library-used-by-this-plugin"

module Fluent::Plugin
  class ExampleInput < Input
    Fluent::Plugin.register_input('example', self)

    def configure(conf)
      super
      # 設定の読み込みとバリデーションをここで行う
    end

    def start
      super
      # プラグインの動作開始に関わる処理はここに記述
    end

    def shutdown
      # 終了処理
      super
    end
  end
end
