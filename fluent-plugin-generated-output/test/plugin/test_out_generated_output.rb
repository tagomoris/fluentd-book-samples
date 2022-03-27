require "helper"
require "fluent/plugin/out_generated_output.rb"

class GeneratedOutputOutputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Output.new(Fluent::Plugin::GeneratedOutputOutput).configure(conf)
  end
end
