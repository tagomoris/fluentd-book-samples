require "fluent/plugin/output"

module Fluent::Plugin
  class NiceServiceOutput < Output
    Fluent::Plugin.register_output('nice_service', self)

    helpers :timer

    config_param :verify_interval, :time, default: 10

    def start
      super
      @unconfirmed_ids = []

      timer_execute(:nice_output_commit, @verify_interval) do
        log.debug "checking ids", ids: @unconfirmed_ids.dup
        @unconfirmed_ids.dup.each do |chunk_id|
          if exist_at_somewhere?(chunk_id)
            log.debug "committing the id", chunk_id: chunk_id
            commit_write(chunk_id)
            @unconfirmed_ids.delete(chunk_id)
          end
        end
      end
    end

    def try_write(chunk)
      if chunk.empty?
        commit_write(chunk.unique_id)
        return
      end

      array = []
      chunk.each do |time, record| # timeはEventTime、recordはHash
        array << {"time" => time, "record" => record}
      end
      send_to_somewhere(chunk.unique_id, JSON.dump(array))
      @unconfirmed_ids << chunk.unique_id
    end

    def send_to_somewhere(chunk_id, data)
      log.debug "sending a data", chunk_id: chunk_id
      # ここに、外部にdataを送信するコードを記述
    end

    def exist_at_somewhere?(chunk_id)
      # ここで、外部サービスにてchunk_idを確認するコードを記述
      # 確認できたらtrue、できないならfalseを返す
      true
    end
  end
end
