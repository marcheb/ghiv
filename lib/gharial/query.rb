module Gharial
  class Query
    def initialize(collection)
      @collection = collection
      @query = []
    end

    attr_reader :creator, :direction, :labels, :sort

    def all
      self
    end

    def creator(user_name)
      @creator = user_name
      self
    end

    def direction(direction)
      @direction = direction
      self
    end

    def execute
      self.parse
      records = Transceiver.new("/#{@collection}#{'?' + @query.join('&') if not @query.empty?}", ssl: true).get
      records.map { |r| Gharial.const_get(@collection.capitalize).new(r) }
    end

    def labels(elements)
      @labels = elements
      self
    end

    def parse
      @query << "creator=#{@creator}" if @creator
      @query << "direction=#{@direction}" if @direction and ['asc', 'desc'].include? @direction
      @query << "labels=#{@labels.join(',')}" if @labels and not @labels.empty?
      @query << "sort=#{@sort}" if @sort and ['comments', 'created', 'updated'].include? @direction
    end

    def sort(filter)
      @sort = filter
      self
    end

  end
end
