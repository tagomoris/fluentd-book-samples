require "fluent/plugin/output"

module Fluent::Plugin
  class BrilliantServiceOutput < Output
    Fluent::Plugin.register_output('brilliant_service', self)

    def process(tag, es)
      es.each do |time, record| # timeはEventTimeオブジェクト、recordはHash
        send_event_to_somewhere(tag, time, record)
      end
    end

    def send_event_to_somewhere(tag, time, record)
      log.debug "sending an event", record: record
      # ここに、外部にtag, time, recordを送信するコードを記述
    end
  end
end
