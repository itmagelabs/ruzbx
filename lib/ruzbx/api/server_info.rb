# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/apiinfo/version
    class ServerInfo < Item
      def self.get
        entity = Entity.build do
          no_auth
          rpc_method 'apiinfo.version'
          data params: []
        end
        new(entity.commit)
      end
    end
  end
end
