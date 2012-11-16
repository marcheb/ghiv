module Gharial
  class Query
    Gharial::Configs.load!(File.expand_path(File.dirname(__FILE__)) + '/../../config/config.yml')
    GH_URL = "#{Gharial::Configs.github[:api_url]}/#{Gharial::Configs.github[:user]}/#{Gharial::Configs.github[:repository]}"

    def initialize(collection)
      @collection = collection
    end

    attr_reader :labels

    def all
      execute
    end

    def creator(user_name)
      @creator = user_name
      self
    end

    def execute
      self.parse
      records = Gharial::Transceiver.new("#{GH_URL}/#{@collection}#{'?' + @a.join('&') if not @a.empty?}", ssl: true).get
      records.map { |r| Gharial.const_get(@collection.capitalize).new(r) }
    end

    def labels(elements=[])
      @labels = elements
      self
    end

    def parse
      @a = []
      @a << "labels=#{@labels.join(',')}" if @labels and not @labels.empty?
      @a << "creator=#{@creator}" if @creator
    end
  end
end
