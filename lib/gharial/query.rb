module Gharial
  class Query
    Configs.load!(File.expand_path(File.dirname(__FILE__)) + '/../../config/config.yml')
    GH_URL = "#{Configs.github[:api_url]}/#{Configs.github[:user]}/#{Configs.github[:repository]}"

    def initialize(collection)
      @collection = collection
      @query = []
    end

    attr_reader :creator, :direction, :labels, :sort

    def all
      execute
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
      records = Transceiver.new("#{GH_URL}/#{@collection}#{'?' + @query.join('&') if not @query.empty?}", ssl: true).get
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
