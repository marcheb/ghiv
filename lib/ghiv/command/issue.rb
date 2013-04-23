require 'optparse'

module Ghiv::Command
  class Issue < Base
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def options
      OptionParser.new do |options|
        options.banner = "Usage: ghiv issue [issue number(Integer)|options]"
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
      end
    end

    def non_options_args
      (ARGV[0].to_i ? @query.number(ARGV[0]) : puts("You have to use an Integer"))
    end

    def render(response)
      Ghiv::UI.issue response
    end
  end
end
