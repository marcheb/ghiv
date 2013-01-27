module Gharial
  class Client
    def initialize(query)
      @query = query
      @query.set_from_config
      @query.parse
    end

    def get
      records = Transceiver.new("/issues#{'/' + @query.number.to_s if @query.number }#{'?' + @query.elements.join('&') if @query.elements?}", ssl: true).get
      records.is_a?(Array) ? records.map { |r| Issues.new(r) } : Issues.new(records)
    end

    private
    def self.method_missing(name, *args, &block)
      begin
        (args.empty? || args.first.empty?) ? @query.send(name) : @query.send(name, args.first)
      rescue
        fail(NoMethodError, "unknown method \"#{name}\"", caller)
      end
    end
  end
end
