module Ghiv
  class Query
    def self.format_value(value)
      value.is_a?(Array) ? value.join(',') : value
    end

    def self.params
      [:creator, :direction, :labels, :milestone, :sort, :state]
    end

    extend MethodChain
    Query.params.push(:number).each { |p| chained_attr_accessor p }
    attr_reader :elements

    def initialize
      @elements = []
    end

    def parse
      Query.params.each { |q| elements << "#{q.to_s}=#{Query.format_value(self.send(q.to_s))}" if self.send(q) }
    end

    def set_from_config
      Query.params.each { |c| self.send("#{c}", Config.send("query_#{c}")) if Config.send("query_#{c}") }
    end
  end
end
