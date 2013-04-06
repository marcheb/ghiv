require 'optparse'

module Ghiv
  class Runner
    def initialize(arguments, stdin, stdout)
      @arguments = arguments
      @query = Query.new
      @stdin = stdin
      @stdout = stdout
    end

    def run
      set_default
      parse_options
      response = Client.new(@query).get

      if Config.raw then UI.raw response
      elsif @query.number then UI.show response
      else UI.list response
      end
    end

    def parse_options
      options = OptionParser.new
      options.banner = "Usage: ghiv [options]"
      options.separator "Global options:"
      options.on('-u', '--user USER', "Your Github username")   { |user| Config.user = user }
      options.on('-p', '--password PASSWORD', "Your Github password")   { |password| Config.password = password }
      options.on('-r', '--repository REPOSITORY',"Your Github repository") { |repository| Config.repository = repository }
      options.on('-R', '--[no-]raw', "Display the raw JSON response from Github") { |raw| Config.raw = raw }
      options.separator ""
      options.separator "Specific options:"
      options.on('-c', '--creator CREATOR', "Creator username") { |creator| Config.query_creator = creator }
      options.on('-d', '--direction [DIRECTION]', [:asc, :desc], "Direction for the result [asc|desc]") { |direction| Config.query_direction = direction }
      options.on('-l', '--labels a,b,c', Array, "List of labels separated by commas") { |labels| Config.query_labels = labels }
      options.on('-m', '--milestone MILESTONE', /\d+|\*|none/, "The number of a specific milestone. \"none\" for no milestone and \"*\" for any milestone") { |milestone| Config.query_milestone = milestone }
      options.on('-n', '--number NUMBER', Integer, "The number of a specific issue") { |number| @query.number number }
      options.on('-s', '--sort [SORT]', [:created, :comments, :updated], "Sort [created|comments|updated]") { |sort| Config.query_sort = sort }
      options.on('-S', '--state [STATE]', [:open, :closed], "State [open|closed]") { |state| Config.query_state = state }
      options.on_tail('-h', '--help', "Show this message") { puts(options); exit }

      options.parse!(@arguments)
    end

    def set_default
      Config.in_stream = @stdin
      Config.out_stream = @stdout
      Config.raw = false
      query_config = [[:direction, :asc], [:sort, :created], [:state, :open]]
      query_config.each { |q, a| Config.send("query_#{q}=", a) if Config.send("query_#{q}") and not Config.send("query_#{q}").empty? }
    end
  end
end
