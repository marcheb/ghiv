module Gharial
  class Base
    def self.collection_name
      self.name.split('::').last.downcase
    end

    def initialize(hash)
      accessors!
      hash.each { |k,v| instance_variable_set("@#{k}", v) if self.class.fields.include? k }
    end

    private
    def self.method_missing(name, *args, &block)
      begin
        query = Query.new(self.collection_name)
        (args.empty? || args.first.empty?) ? query.send(name) : query.send(name, args.first)
      rescue
        fail(NoMethodError, "unknown method \"#{name}\"", caller)
      end
    end

    def accessors!
      Issues.fields.each { |f| self.class.send(:attr_accessor, f) }
    end
  end
end
