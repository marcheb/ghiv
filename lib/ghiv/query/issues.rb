module Ghiv::Query
  class Issues < Base
    def self.params
      [:creator, :direction, :labels, :milestone, :sort, :state]
    end

    self.params.each { |p| chained_attr_accessor p } if self.params


    def build
      path + '?' + Issues.params.map { |p| "#{p.to_s}=#{Issues.format_value(self.send(p.to_s))}" if self.send(p) }.compact.join('&')
    end
  end
end
