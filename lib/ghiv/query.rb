module Ghiv
  module Query
    class Base
      def self.format_value(value)
        value.is_a?(Array) ? value.join(',') : value
      end

      def self.params
        nil
      end


      extend Ghiv::MethodChain
      attr_reader :elements

      def initialize
        @elements = []
      end

      def parse
        eval(self.class.name).params.each { |q| elements << "#{q.to_s}=#{eval(self.class.name).format_value(self.send(q.to_s))}" if self.send(q) } if eval(self.class.name).params
      end

      def default_queries_values
        nil
      end

      def set_from_config
        eval(self.class.name).params.each { |c| self.send("#{c}", Config.send("query_#{c}")) if Config.send("query_#{c}") } if eval(self.class.name).params
      end
    end
  end
end
