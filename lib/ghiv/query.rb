module Ghiv
  class Query
    attr_reader :creator, :direction, :elements, :labels, :number, :sort

    def initialize
      @number = nil
    end

    def creator(user_name)
      @creator = user_name
      self
    end

    def direction(direction)
      @direction = direction
      self
    end

    def direction?
      [:asc, :desc].include? @direction
    end

    def elements?
      @elements and not @elements.empty?
    end

    def labels(elements)
      @labels = elements
      self
    end

    def labels?
      @labels and not @labels.empty?
    end

    def number=(number)
      @number = number
      self
    end

    def set_from_config
      creator Config.query_creator
      direction Config.query_direction
      labels Config.query_labels
      sort Config.query_sort
      state Config.query_state
      #['direction', 'sort'].each { |c| self.send("#{c}=", Config.send("query_#{c}")) if Config.send("query_#{c}" }
    end

    def parse
      @elements = []
      @elements << "creator=#{@creator}" if @creator
      @elements << "direction=#{@direction}" if direction?
      @elements << "labels=#{@labels.join(',')}" if labels?
      @elements << "sort=#{@sort}" if sort?
      @elements << "state=#{@state}" if state?
    end

    def sort(filter)
      @sort = filter
      self
    end

    def sort?
      [:comments, :created, :updated].include? @sort
    end

    def state(state)
      @state = state
      self
    end

    def state?
      [:open, :closed].include? @state
    end

  end
end
