module Ghiv
  module Query
    class Base
      def self.format_value(value)
        value.is_a?(Array) ? value.join(',') : value
      end

      extend Ghiv::MethodChain

      def initialize
        @elements = []
        set_from_config
      end

      def path
        "/issues"
      end

      def set_from_config
        eval(self.class.name).params.each { |c| self.send("#{c}", Config.send("query_#{c}")) if Config.send("query_#{c}") } if eval(self.class.name).params
      end
    end
  end
end
