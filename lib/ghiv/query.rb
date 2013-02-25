module Ghiv
  class Query
    extend MethodChain
    chained_attr_accessor :creator, :direction, :elements, :labels, :milestone, :number, :sort, :state

    def elements?
      @elements and not @elements.empty?
    end

    def set_from_config
      [:creator, :direction, :labels, :milestone, :sort, :state].each { |c| self.send("#{c}", Config.send("query_#{c}")) if Config.send("query_#{c}") }
    end

    def parse
      @elements = []
      @elements << "creator=#{@creator}" if @creator
      @elements << "direction=#{@direction}" if @direction
      @elements << "labels=#{@labels.join(',')}" if @labels
      @elements << "milestone=#{@milestone}" if @milestone
      @elements << "sort=#{@sort}" if @sort
      @elements << "state=#{@state}" if @state
    end
  end
end
