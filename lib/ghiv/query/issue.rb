module Ghiv::Query
  class Issue < Base
    def self.params
      [:number]
    end

    self.params.each { |p| chained_attr_accessor p } if self.params


    def build
      path + "/" + number
    end
  end
end
