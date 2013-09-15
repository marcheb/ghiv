require 'optparse'

module Ghiv
  class Runner
    def initialize(stdin, stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def run
      set_default
      parse_global.order!
      parse_command(ARGV.shift)
    end

    def parse_command(command)
      if !command.nil? and Command::Base.commands.include?(command.to_sym)
        eval("Command::#{command.capitalize}").new
      else
        puts "Invalid command\n\nCommand:\n#{Command::Base.commands.map{|k,v| "\t#{k.to_s}\t\t #{v}" }.join("\n")}\n\n"
        exit
      end
    end

    def parse_global
      OptionParser.new do |options|
        options.banner = "Usage: ghiv [options]"
        options.separator "Global options:"
        options.on('-u', '--user USER', "Your Github username")   { |user| Config.user = user }
        options.on('-p', '--password PASSWORD', "Your Github password")   { |password| Config.password = password }
        options.on('-P', '--[no-]pretty_json', "Display pretty json on raw output")   { |pretty_json| Config.pretty_json = pretty_json }
        options.on('-r', '--repository REPOSITORY',"Your Github repository") { |repository| Config.repository = repository }
        options.on('-R', '--[no-]raw', "Display the raw JSON response from Github") { |raw| Config.raw = raw }
        options.on_tail('-h', '--help', "Show this message") { puts(options); exit }
        options.on_tail ""
        options.on_tail "Commands:"
        Command::Base.commands.each { |k,v| options.on_tail "\t#{k.to_s}\t\t #{v}" }
      end
    end

    def set_default
      Config.in_stream = @stdin
      Config.out_stream = @stdout
      Config.pretty_json = true
      Config.raw = false
    end
  end
end
