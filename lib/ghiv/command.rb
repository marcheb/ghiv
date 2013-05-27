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
        set_config if default_queries_values
        options.parse!
        non_options_args if non_options_args
      end

      def default_queries_values
        nil
      end

      def non_options_args
        nil
      end

      def render(response)
        Ghiv::UI.send(self.class.name.downcase.sub('ghiv::command::',''), response)
      end

      def set_config
        default_queries_values.each { |q, a| Config.send("query_#{q}=", a) if Config.send("query_#{q}") and not Config.send("query_#{q}").empty? }
      end
    end
  end
end
