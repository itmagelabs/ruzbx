# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/ruzbx'

class ConnectionTest < Test::Unit::TestCase
  def test_connection
    ENV['RUZBX_TOKEN'] = 'secret_token'
    Ruzbx::Connection.new.run
  end

  def test_class
    assert_instance_of Faraday::Connection, test_connection
  end
end
