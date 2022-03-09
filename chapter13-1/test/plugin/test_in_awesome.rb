# AwesomeInputプラグインのテストを書く場合
require "fluent/test"

class AwesomeInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  test 'the first test case' do
    assert_equal true, true
  end
end
