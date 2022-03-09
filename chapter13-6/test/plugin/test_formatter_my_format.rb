require "fluent/test"
require 'fluent/test/driver/formatter'
require 'fluent/plugin/formatter_my_format'

class MyFormatFormatterTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @tag = 'tag'
    @time = Fluent::EventTime.now
  end

  def create_driver(config)
    d = Fluent::Test::Driver::Formatter.new(Fluent::Plugin::MyFormatFormatter)
    d.configure(config)
  end

  CONFIG = ''

  test 'key-value separator is pipe, pairs separator is comma' do
    d = create_driver(CONFIG)
    text = d.instance.format(@tag, @time, {'K1' => '1', 'K2' => '2'})
    assert_equal "K1|1,K2|2\n", text
  end
end
