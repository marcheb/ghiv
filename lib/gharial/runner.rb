module Gharial
  class Runner
    def initialize(arguments)
      @command = arguments[0]
      @collections = arguments[1]
    end

    def run
      Gharial.const_get(@collections.capitalize).send(@command)
    end
  end
end
