# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    # https://www.zabbix.com/documentation/current/en/manual/api/reference/user/checkauthentication
    class Myself < Item
      def self.get
        entity = Entity.build do
          no_auth
          rpc_method 'user.checkAuthentication'
          data params: { token: Configuration.token }
        end
        new(entity.commit)
      end

      def name
        @data
      end
    end
  end
end
