#
# Copyright 2022- Satoshi Moris Tagomori
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/parser"

module Fluent
  module Plugin
    class GeneratedParserParser < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("generated_parser", self)

      def parse(text)
        yield time, record
      end
    end
  end
end
