module Ghiv
  class Issues
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def initialize(hash)
      hash.each do |k,v|
        self.class.__send__(:attr_accessor, k)
        instance_variable_set("@#{k}", v) if respond_to? k
      end
    end
  end
end
