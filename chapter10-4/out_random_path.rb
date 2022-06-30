require "fluent/plugin/output"

module Fluent::Plugin
  class RandomPathOutput < Output
    Fluent::Plugin.register_output('random_path', self)

    config_param :use_random_file_name, :bool

    def multi_workers_ready?
      if use_random_file_name
        true
      else
        false
      end
    end

    def write(chunk)
      if use_random_file_name
        file_name = dump_unique_id_hex(generate_unique_id)
        # file_nameに対して出力
      else
        # タグなどを元にファイル名を決定して出力
      end
    end
  end
end
