require "fluent/plugin/output"

module Fluent::Plugin
  class FantasticServiceOutput < Output
    Fluent::Plugin.register_output('fantastic_service', self)

    def process(tag, es)
      es.each do |time, record| # timeはEventTime、recordはHash
        success = false
        until success
          begin
            send_event_to_somewhere(tag, time, record)
            success = true
          rescue => e
            log.error "Failed to send an event", error: e
          end
        end
      end
    end

    def send_event_to_somewhere(tag, time, record)
      log.debug "sending an event", record: record
      # ここに、外部にtag, time, recordを送信するコードを記述
    end
  end
end
