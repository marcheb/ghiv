module Ghiv
  class Client
    ##################################
    # PUBLIC INSTANCE METHOD         #
    ##################################
    attr_reader :service

    def initialize(service)
      @query = eval("Query::#{service.to_s.capitalize}").new

      @query.set_from_config
      @query.parse
      @service = service
    end

    def get(service=@service)
      response = self.send("get_#{service}")
      Config.raw ? response : format(response)
    end

    def get_comments
      Transceiver.new("/issues/#{@query.number.to_s}/comments", ssl: true).get
    end

    def get_issue
      Transceiver.new("/issues/#{@query.number}", ssl: true).get
    end

    def get_issues
      Transceiver.new("/issues#{'?' + @query.elements.join('&') if not @query.elements.empty?}", ssl: true).get
    end

    def format(records)
      records.is_a?(Array) ? records.map { |r| ClassFactory.new(r) } : ClassFactory.new(records)
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
