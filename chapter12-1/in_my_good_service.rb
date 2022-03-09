require "fluent/plugin/input" # これでFluent::Plugin::Inputを参照

module Fluent::Plugin
  class MyGoodServiceInput < Input
    Fluent::Plugin.register_input('my_good_service', self)
  end
end
