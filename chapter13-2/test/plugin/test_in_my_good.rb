require "serverengine/utils" # ServerEngineのバグ除け
# https://github.com/treasure-data/serverengine/pull/119

require "fluent/test"
require "fluent/test/driver/input"
require "fluent/plugin/in_my_good"

class MyGoodInputTest < Test::Unit::TestCase
  def setup # テスト実行の前に行われる処理として、テスト用に環境のセットアップ
    Fluent::Test.setup
  end

  def create_driver(config)
    # テストドライバとプラグインの初期化用
    # テスト内に頻出するのでメソッドにしておくと便利
    d = Fluent::Test::Driver::Input.new(Fluent::Plugin::MyGoodInput)
    d.configure(config)
  end

  # テスト時にプラグインに与える設定、<source>の内側（@typeは不要）
  CONFIG = <<~EOS
    interval 5s
    tag "test.output"
  EOS

  test 'MyGoodInput should emit events for ...' do
    d = create_driver(CONFIG) # テストドライバを引数の設定で初期化

    d.run(expect_records: 2) # ドライバ経由でプラグインを起動、終了条件付き

    # Inputプラグインから出力されたイベントの検査
    d.events.each do |tag, time, record|
      assert_equal "test.output", tag
      # ...
    end
  end
end
