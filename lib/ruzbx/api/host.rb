# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/host/object
    class Host < Item
      # rubocop:disable Metrics/MethodLength
      def self.create(opts, &block)
        entity = Entity.build do
          rpc_method 'host.create'
          data params: {
            host: opts[:name],
            interfaces: [{ type: 1, main: 1, useip: 1, ip: opts[:ip],
                           dns: '', port: '10050' }],
            groups: opts[:groups],
            tags: [{ tag: 'creator', value: 'bot' }],
            templates: opts[:templates],
            macros: []
          }
          instance_eval(&block) if block_given?
        end
        new(entity.commit)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
