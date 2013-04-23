require 'optparse'

module Ghiv
  module Command
    class Base
      ##################################
      # PUBLIC CLASS METHOD         #
      ##################################
      def self.commands
        {issues: 'List issues', issue: 'Display a specific issue'}
      end


      ##################################
      # PUBLIC INSTANCE METHOD         #
      ##################################
      def initialize
        @query = Query.new
        set_config if default_queries
        options.parse!
        non_options_args if non_options_args

        client = Client.new(@query)

        response = client.get

        render response
      end

      def default_queries
        nil
      end

      def non_options_args
        nil
      end

      def set_config
        default_queries.each { |q, a| Config.send("query_#{q}=", a) if Config.send("query_#{q}") and not Config.send("query_#{q}").empty? }
      end
    end
  end
end
