require "fluent/plugin/input"

module Fluent::Plugin
  class DisplayParamInput < Input
    Fluent::Plugin.register_input('display_param', self)

    config_param :myparam, :string

    def initialize
      super
      # ここではまだ設定は読み込まれていない
    end

    def configure(conf)
      # ここではまだ設定は読み込まれていない
      myparam #=> nil
      log.debug "Before super in #configure", myparam: myparam

      super # superの先でconfの内容の解析と値のセットが行われる
      # 不正なパラメータ値や必須パラメータ未設定があればエラー（例外）

      # 設定ファイルから読み込まれた値になる
      myparam #=> "a value"
      log.debug "After super in #configure", myparam: myparam
    end

    def start
      super
      # configureが呼ばれた後なのでパラメータの値が参照できる
      myparam #=> "a value"
      log.debug "In #start", myparam: myparam
    end
  end
end
