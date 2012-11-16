module Gharial
  class Base
    Gharial::Configs.load!(File.expand_path(File.dirname(__FILE__)) + '/../../config/config.yml')
    GH_URL = "#{Gharial::Configs.github[:api_url]}/#{Gharial::Configs.github[:user]}/#{Gharial::Configs.github[:repository]}"

    def self.all
      records = Gharial::Transceiver.new("#{GH_URL}/#{self.collection_name}", ssl: true).get
      records.map { |r| self.new(r)}
    end

    def self.collection_name
      self.name.split('::').last.downcase
    end

    #Instance method
    def initialize(hash)
      accessors!
      hash.each { |k,v| instance_variable_set("@#{k}", v) if self.class.fields.include? k }
    end

    private
    def accessors!
      Issues.fields.each { |f| self.class.send(:attr_accessor, f) }
    end
  end
end
