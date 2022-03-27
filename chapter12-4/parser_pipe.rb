# 各行のパイプ（|）で区切られた値を、番号をキーにしたレコードとして返す
# 例：2021-07-05 16:21:33 +0900|one|two|three
# 結果：
#   日時：2021-07-05 16:21:33 +0900
#   レコード：{"1": "one", "2": "two", "3": "three"}
require 'fluent/plugin/parser'

module Fluent::Plugin
  class PipeParser < Parser
    Fluent::Plugin.register_parser('pipe', self)

    def parse(text) # ブロック引数を受け取る
      text.split("\n").each do |line|
        values = line.split("|")
        raw_record = {}
        values.each_with_index do |value, index|
          raw_record[index.to_s] = value
        end
        time, record = convert_values(parse_time(raw_record), raw_record)
        yield time, record
      end
    end
  end
end
