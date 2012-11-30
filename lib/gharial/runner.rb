module Gharial
  class Runner
    def initialize(arguments)
      @collections = arguments.delete_at(0)
      @command = arguments.delete_at(0)
      @arguments = arguments
    end

    def run
      Gharial.const_get(@collections.capitalize).send(@command, @arguments).execute.each { |r| puts r.number.to_s + " : " + r.title }
      puts
      puts '"gharial issues show:[number]" to see details'
    end
  end
end
