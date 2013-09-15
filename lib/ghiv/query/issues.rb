module Ghiv::Query
  class Issues < Base
    def self.params
      [:creator, :direction, :labels, :milestone, :sort, :state]
    end

    self.params.each { |p| chained_attr_accessor p } if self.params

    def default_queries_values
      [[:direction, :asc], [:sort, :created], [:state, :open]]
    end
  end
end
