# frozen_string_literal: true

module Ruzbx
  module Api
    # TODO
    class Item
      attr_reader :data

      def initialize(data = nil)
        @data = data
      end
    end
  end
end
