module Ghiv
  class ClassFactory
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def initialize(record)
      record.each do |k,v|
        self.class.__send__(:attr_accessor, k)
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
