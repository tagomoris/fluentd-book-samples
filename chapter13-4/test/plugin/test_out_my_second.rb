require "fluent/test"
require 'fluent/test/driver/output'
require 'fluent/plugin/out_my_second'

require 'flexmock/test_unit'
# この行により、テストケース末尾で自動的にモックの検証を行うようになる

class MySecondOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @test_client = flexmock('test_client')
  end

  def create_driver(config)
    d = Fluent::Test::Driver::Output.new(Fluent::Plugin::MySecondOutput)
    d.configure(config)
    d.instance.client = @test_client
    d
  end

  CONFIG = <<~EOS
    username tagomoris
    apikey   1234/deadbeefc0ffee
  EOS

  test 'data will be transmitted correctly' do
    time = Fluent::EventTime.now
    record = {"key" => "excellent value"}
    expected_record = record.merge("timestamp" => time.to_f)

    @test_client.should_receive(:transmit) \
      .with("tagomoris", "1234/deadbeefc0ffee", [expected_record])

    d = create_driver(CONFIG)
    d.run do
      d.feed("tag", time, record)
    end
    # ここで自動的にモック検証が行われる
  end
end
