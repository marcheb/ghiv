require 'optparse'

module Ghiv
  class Runner
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def initialize(arguments, stdin, stdout)
      @arguments = arguments
      @query = Query.new
      @stdin = stdin
      @stdout = stdout
    end

    def run
      set_default
      parse_global.order!
      parse_command(ARGV.shift)
      client = Client.new(@query)

      response = client.get

      if Config.raw
        UI.raw response
      elsif @query.number
        options = {}
        options[:comments] = client.get('comments') if response.comments > 0
        UI.issue response, options
      else
        UI.issues response
      end
    end

    def commands
      {issues: 'List issues', issue: 'Display a specific issue'}
    end

    def parse_command(command)
      (!command.nil? and commands.include?(command.to_sym)) ? send("parse_#{command}") : raise("Invalid command\n\nCommand:\n#{commands.map{|k,v| "\t#{k.to_s}\t\t #{v}" }.join("\n")}\n\n")
    end

    def parse_issue
      OptionParser.new do |options|
        options.banner = "Usage: ghiv issue [issue number(Integer)|options]"
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
      end.parse!
      (@arguments[0].to_i ? @query.number(@arguments[0]) : raise("You have to use an Integer"))
    end

    def parse_issues
      OptionParser.new do |options|
        options.separator "Issues options:"
        options.on('-c', '--creator CREATOR', "Creator username") { |creator| Config.query_creator = creator }
        options.on('-d', '--direction [DIRECTION]', [:asc, :desc], "Direction for the result [asc|desc]") { |direction| Config.query_direction = direction }
        options.on('-l', '--labels a,b,c', Array, "List of labels separated by commas") { |labels| Config.query_labels = labels }
        options.on('-m', '--milestone MILESTONE', /\d+|\*|none/, "The number of a specific milestone. \"none\" for no milestone and \"*\" for any milestone") { |milestone| Config.query_milestone = milestone }
        options.on('-s', '--sort [SORT]', [:created, :comments, :updated], "Sort [created|comments|updated]") { |sort| Config.query_sort = sort }
        options.on('-S', '--state [STATE]', [:open, :closed], "State [open|closed]") { |state| Config.query_state = state }
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
      end.parse!
    end

    def parse_global
      OptionParser.new do |options|
        options.banner = "Usage: ghiv [options]"
        options.separator "Global options:"
        options.on('-u', '--user USER', "Your Github username")   { |user| Config.user = user }
        options.on('-p', '--password PASSWORD', "Your Github password")   { |password| Config.password = password }
        options.on('-r', '--repository REPOSITORY',"Your Github repository") { |repository| Config.repository = repository }
        options.on('-R', '--[no-]raw', "Display the raw JSON response from Github") { |raw| Config.raw = raw }
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
        options.on_tail ""
        options.on_tail "Commands:"
        commands.each { |k,v| options.on_tail "\t#{k.to_s}\t\t #{v}" }

      end
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
