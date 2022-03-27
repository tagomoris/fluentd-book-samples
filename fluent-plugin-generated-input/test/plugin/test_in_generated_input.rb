require "helper"
require "fluent/plugin/in_generated_input.rb"

class GeneratedInputInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::GeneratedInputInput).configure(conf)
  end
end
