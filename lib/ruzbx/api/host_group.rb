# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/hostgroup/object
    class HostGroup < Item
      def self.get(names, &block)
        entity = Entity.build do
          rpc_method 'hostgroup.get'
          data params: { output: 'extend', filter: { name: names } }
          instance_eval(&block) if block_given?
        end
        new(entity.commit)
      end

      def ids
        @data['result'].map { |i| i['groupid'] } unless @data['result'].empty?
      end
    end
  end
end
