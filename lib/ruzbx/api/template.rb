# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/template/object
    class Template < Item
      def self.get(names, &block)
        entity = Entity.build do
          rpc_method 'template.get'
          data params: { output: 'extend', filter: { host: names } }
          instance_eval(&block) if block_given?
        end
        new(entity.commit)
      end

      def ids
        @data['result'].map { |i| i['templateid'] } unless @data['result'].empty?
      end
    end
  end
end
