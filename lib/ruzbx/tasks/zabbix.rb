# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'
require 'json'

module Ruzbx
  module Tasks
    # TODO
    class Jira
      include ::Rake::DSL if defined?(::Rake::DSL)

      def initialize
        @options = {
          issuetype: 'Task'
        }
        @parser = OptionParser.new
        define
      end

      def parser
        yield
        args = @parser.order!(ARGV) {}
        @parser.parse!(args)
      end

      def options(name)
        @options[name]
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def define
        generate 'whoami' do
          puts Ruzbx::Api::Myself.get.name
        end
        generate 'url' do
          puts Ruzbx::Configuration.url
        end
        generate 'server_info' do
          puts Ruzbx::Api::ServerInfo.get.data.to_json
        end
        generate 'template' do
          parser do
            @parser.banner = "Usage: rake zabbix:template -- '[options]'"
            @parser.on('-n NAME', '--name=NAME') { |name| @options[:name] = name }
          end

          options = @options
          result = Ruzbx::Api::Template.get options[:name]
          result.data['result'].each { |i| puts JSON.pretty_generate(i) }
        end
        generate 'create' do
          parser do
            @parser.banner = "Usage: rake zabbix:create -- '[options]'"
            @parser.on('-n NAME', '--name=NAME') { |name| @options[:name] = name.strip }
            @parser.on('-i IP', '--ip=NAME') { |ip| @options[:ip] = ip }
            @parser.on('-t NAME', '--templates=NAME') { |templates| @options[:templates] = templates.strip.split(',') }
            @parser.on('-g NAME', '--hostgroups=NAME') do |hostgroups|
              @options[:hostgroups] = hostgroups.strip.split(',')
            end
          end

          options = @options
          options[:templates] = Ruzbx::Api::Template.get(options[:templates]).ids.map do |i|
            { templateid: i }
          end
          options[:groups] = Ruzbx::Api::HostGroup.get(options[:hostgroups]).ids.map do |i|
            { groupid: i }
          end
          result = Ruzbx::Api::Host.create options
          result.data['result'].each { |i| puts JSON.pretty_generate(i) }
        end
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength

      def generate(name, &block)
        fullname = "zabbix:#{name}"
        desc "Run #{fullname}"

        Rake::Task[fullname].clear if Rake::Task.task_defined?(fullname)
        namespace :zabbix do
          task name do
            instance_eval(&block)
          end
        end
      end
    end
  end
end
