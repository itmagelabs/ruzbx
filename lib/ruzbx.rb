# frozen_string_literal: true

require 'faraday'
require 'json'
require_relative 'ruzbx/version'
require_relative 'ruzbx/connection'
require_relative 'ruzbx/configuration'
require_relative 'ruzbx/entity'
require_relative 'ruzbx/api/item'
require_relative 'ruzbx/api/myself'
require_relative 'ruzbx/api/server_info'
require_relative 'ruzbx/api/host'
require_relative 'ruzbx/api/template'
require_relative 'ruzbx/api/host_group'

module Ruzbx
  class Error < StandardError; end
end
