module Ghiv
  class Client
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    def initialize(query)
      @query = query
      @query.set_from_config
      @query.parse
    end

    def get
      response = Transceiver.new("/issues#{'/' + @query.number.to_s if @query.number }#{'?' + @query.elements.join('&') if not @query.elements.empty?}", ssl: true).get
      Config.raw ? response : format(response)
    end

    def format(records)
      records.is_a?(Array) ? records.map { |r| Issues.new(r) } : Issues.new(records)
    end

    ##################################
    # PRIVATE METHOD                 #
    ##################################
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
