require 'optparse'

module Ghiv::Command
  class Issues < Base
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def initialize
      #@query = Ghiv::Query::Issues.new
      super
      client = Ghiv::Client.new(:issues)
      render client.get
    end

    def options
      OptionParser.new do |options|
        options.separator "Issues options:"
        options.on('-c', '--creator CREATOR', "Creator username") { |creator| Ghiv::Config.query_creator = creator }
        options.on('-d', '--direction [DIRECTION]', [:asc, :desc], "Direction for the result [asc|desc]") { |direction| Ghiv::Config.query_direction = direction }
        options.on('-l', '--labels a,b,c', Array, "List of labels separated by commas") { |labels| Ghiv::Config.query_labels = labels }
        options.on('-m', '--milestone MILESTONE', /\d+|\*|none/, "The number of a specific milestone. \"none\" for no milestone and \"*\" for any milestone") { |milestone| Ghiv::Config.query_milestone = milestone }
        options.on('-s', '--sort [SORT]', [:created, :comments, :updated], "Sort [created|comments|updated]") { |sort| Ghiv::Config.query_sort = sort }
        options.on('-S', '--state [STATE]', [:open, :closed], "State [open|closed]") { |state| Ghiv::Config.query_state = state }
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
      end
    end

    def default_queries_values
      [[:direction, :asc], [:sort, :created], [:state, :open]]
    end
  end
end
