module Ghiv::Query
  class Issue < Base
    ##################################
    # PUBLIC CLASS METHOD            #
    ##################################
    def self.params
      [:number]
    end


    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    self.params.each { |p| chained_attr_accessor p } if self.params

    def default_queries_values
      [[:direction, :asc], [:sort, :created], [:state, :open]]
    end
  end
end
