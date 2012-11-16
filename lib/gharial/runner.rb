module Gharial
  class Runner
    def initialize(arguments)
      @collections = arguments.delete_at(0)
      @command = arguments.delete_at(0)
      @arguments = arguments
    end

    def run
      Gharial.const_get(@collections.capitalize).send(@command, @arguments).inspect
    end
  end
end
