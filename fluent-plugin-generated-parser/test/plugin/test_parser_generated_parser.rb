require "helper"
require "fluent/plugin/parser_generated_parser.rb"

class GeneratedParserParserTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::GeneratedParserParser).configure(conf)
  end
end
