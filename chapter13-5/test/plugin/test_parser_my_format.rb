require "fluent/test"
require 'fluent/test/driver/parser'
require 'fluent/plugin/parser_my_format'

class MyFormatParserTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(config)
    d = Fluent::Test::Driver::Parser.new(Fluent::Plugin::MyFormatParser)
    d.configure(config)
  end

  # テストドライバに与える設定はHashにもできる
  CONFIG = {
    'myparam' => 'value1',
  }

  test 'key-value separator is pipe, pairs separator is comma' do
    d = create_driver(CONFIG)
    d.instance.parse('k1|1,k2|2') do |time, record|
      assert_equal ['k1', 'k2'], record.keys.sort
      assert_equal '1', record['k1']
      assert_equal '2', record['k2']
    end
  end
end
