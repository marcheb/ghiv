module Ghiv
  class Query
    attr_reader :creator, :direction, :elements, :labels, :milestone, :number, :sort, :state

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

    def milestone(milestone)
      @milestone = case milestone
        when 0 then 'none'
        when -1 then '*'
        else milestone.to_s
      end
      self
    end

    def milestone?
      @milestone and not @milestone.empty?
    end

    def number=(number)
      @number = number
      self
    end

    def set_from_config
      [:creator, :direction, :labels, :milestone, :sort, :state].each { |c| self.send("#{c}", Config.send("query_#{c}")) if Config.send("query_#{c}") }
    end

    def parse
      @elements = []
      @elements << "creator=#{@creator}" if @creator
      @elements << "direction=#{@direction}" if direction?
      @elements << "labels=#{@labels.join(',')}" if labels?
      @elements << "milestone=#{@milestone}" if milestone?
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
