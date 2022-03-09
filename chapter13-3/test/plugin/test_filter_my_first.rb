require "fluent/test"
require 'fluent/test/driver/filter'
require 'fluent/plugin/filter_my_first'

class MyFirstFilterTest < Test::Unit::TestCase
  def setup # テスト環境のセットアップはInput同様に行う
    Fluent::Test.setup
  end

  def create_driver(config)
    d = Fluent::Test::Driver::Filter.new(Fluent::Plugin::MyFirstFilter)
    d.configure(config)
  end

  # テスト時にプラグインに与える設定、通常の<filter>の内側（@typeは不要）
  CONFIG = '' # パラメータがない場合は空白文字列にしておく

  test 'MyFirstFilter should filter events like ...' do
    d = create_driver(CONFIG)

    time = Fluent::EventTime.now
    d.run do
      d.feed("testing.tag1", time, {"key1" => "value1", "key2" => 2})
    end

    result = d.filtered
    assert_equal 1, result.size

    first_event = result[0]
    assert_equal time, first_event[0]
    assert_equal "value1", first_event[1]["key1"]
    # ...
  end
end
