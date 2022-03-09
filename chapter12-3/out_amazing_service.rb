require "fluent/plugin/output"

module Fluent::Plugin
  class AmazingServiceOutput < Output
    Fluent::Plugin.register_output('amazing_service', self)

    def process(tag, es)
      es.each do |time, record| # timeはEventTime、recordはHash
        begin
          send_event_to_somewhere(tag, time, record)
        rescue => e
          log.error "Failed to send an event", record: record, error: e
        end
      end
    end

    def send_event_to_somewhere(tag, time, record)
      log.debug "sending an event", record: record
      # ここに、外部にtag, time, recordを送信するコードを記述
    end
  end
end
