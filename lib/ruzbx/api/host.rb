# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/host/object
    class Host < Item
      # rubocop:disable Metrics/MethodLength
      def self.get(name, &block)
        entity = Entity.build do
          rpc_method 'host.get'
          data params: {
            filter: {
              host: [name]
            }
          }
          instance_eval(&block) if block_given?
        end
        new(entity.commit)
      end

      def ids
        @data['result'].map { |i| i['hostid'] } unless @data['result'].empty?
      end

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

      def self.update(name, opts, &block)
        ids = get(name).ids
        entity = Entity.build do
          rpc_method 'host.update'
          data params: {
            hostid: ids.first
          }.merge(opts)
          instance_eval(&block) if block_given?
        end
        new(entity.commit)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
