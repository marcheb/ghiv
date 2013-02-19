module Ghiv
  class Query
    attr_reader :creator, :direction, :elements, :labels, :number, :sort

    def initialize
      @number = nil
    end

    def creator=(user_name)
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
      direction Config.query_direction
      sort Config.query_sort
      #['direction', 'sort'].each { |c| self.send("#{c}=", Config.send("query_#{c}")) if Config.send("query_#{c}" }
    end

    def parse
      @elements = []
      @elements << "creator=#{@creator}" if @creator
      @elements << "direction=#{@direction}" if direction?
      @elements << "labels=#{@labels.join(',')}" if labels?
      @elements << "sort=#{@sort}" if sort?
    end

    def sort(filter)
      @sort = filter
      self
    end

    def sort?
      [:comments, :created, :updated].include? @sort
    end

  end
end
