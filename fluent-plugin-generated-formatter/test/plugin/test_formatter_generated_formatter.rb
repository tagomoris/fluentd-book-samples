require "helper"
require "fluent/plugin/formatter_generated_formatter.rb"

class GeneratedFormatterFormatterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Formatter.new(Fluent::Plugin::GeneratedFormatterFormatter).configure(conf)
  end
end
