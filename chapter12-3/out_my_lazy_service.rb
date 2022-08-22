require "fluent/plugin/output"

module Fluent::Plugin
  class MyLazyServiceOutput < Output
    Fluent::Plugin.register_output('my_lazy_service', self)

    # realtimeの場合は非バッファ
    # stableの場合は非同期バッファ
    # throughputの場合は同期バッファ
    config_param :performance_mode, :enum, \
      list: [:realtime, :stable, :throughput]

    def prefer_buffered_processing
      # realtime以外ならバッファする（同期、非同期）
      @performance_mode != :realtime
    end

    def prefer_delayed_commit
      # stableの場合は非同期バッファする
      @performance_mode == :stable
    end

    def process(tag, es)
      log.debug "processing events"
      # ...
    end

    def write(chunk)
      log.debug "writing a chunk"
      # ...
    end

    def try_write(chunk)
      log.debug "trying to write a chunk"
      # ...
    end
  end
end
