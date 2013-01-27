require 'optparse'

module Gharial
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
      @query.number ? UI.show(response) : UI.list(response)
    end

    def parse_options
      options = OptionParser.new
      options.banner = "Usage: gharial [options]"
      options.separator "Global options:"
      options.on('-u', '--user USER', "Your Github username")   { |u| Config.user = u }
      options.on('-p', '--password PASSWORD', "Your Github password")   { |p| Config.password = p }
      options.on('-r', '--repository REPOSITORY',"Your Github repository") { |r| Config.repository = r }
      options.separator ""
      options.separator "Specific options:"
      options.on('-c', '--creator CREATOR', "Creator username") { |c| @query.creator = c }
      options.on('-d', '--direction [DIRECTION]', [:asc, :desc], "Direction for the result [asc|desc]") { |d| Config.query_direction = d }
      options.on('-n', '--number NUMBER', Integer, "The number of a specific issue [Integer]") { |n| @query.number = n }
      options.on('-s', '--sort [SORT]', [:created, :comments, :updated], "Sort [created|comments|updated]") { |s| Config.query_sort = s }
      options.on_tail('-h', '--help', "Show this message") { puts(options); exit }

      options.parse!(@arguments)
    end

    def set_default
      Config.in_stream = @stdin
      Config.out_stream = @stdout
      query_config = [[:direction, :asc], [:sort, :created]]
      query_config.each { |q, a| Config.send("query_#{q}=", a) if Config.send("query_#{q}") and not Config.send("query_#{q}").empty? }
    end
  end
end
