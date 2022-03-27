require "helper"
require "fluent/plugin/filter_generated_filter.rb"

class GeneratedFilterFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::GeneratedFilterFilter).configure(conf)
  end
end
