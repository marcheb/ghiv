module Ghiv
  class Client
    attr_reader :service

    def initialize(service)
      @query = eval("Query::#{service.to_s.capitalize}").new

      @query.set_from_config
      @query.parse
      @service = service
    end

    def get
      response = Transceiver.new("/issues#{self.send(service)}", ssl: true).get
    end

    def comments
      "/#{@query.number.to_s}/comments"
    end

    def issue
      "/#{@query.number}"
    end

    def issues
      '?' + @query.elements.join('&') if not @query.elements.empty?
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
