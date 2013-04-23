require 'optparse'

module Ghiv::Command
  class Issues < Base
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def options
      OptionParser.new do |options|
        options.separator "Issues options:"
        options.on('-c', '--creator CREATOR', "Creator username") { |creator| Config.query_creator = creator }
        options.on('-d', '--direction [DIRECTION]', [:asc, :desc], "Direction for the result [asc|desc]") { |direction| Config.query_direction = direction }
        options.on('-l', '--labels a,b,c', Array, "List of labels separated by commas") { |labels| Config.query_labels = labels }
        options.on('-m', '--milestone MILESTONE', /\d+|\*|none/, "The number of a specific milestone. \"none\" for no milestone and \"*\" for any milestone") { |milestone| Config.query_milestone = milestone }
        options.on('-s', '--sort [SORT]', [:created, :comments, :updated], "Sort [created|comments|updated]") { |sort| Config.query_sort = sort }
        options.on('-S', '--state [STATE]', [:open, :closed], "State [open|closed]") { |state| Config.query_state = state }
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
      end
    end

    def default_queries
      [[:direction, :asc], [:sort, :created], [:state, :open]]
    end

    def render(response)
      Ghiv::UI.issues response
    end
  end
end
