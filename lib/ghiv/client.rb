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

    def get(service)
      response = self.send("get_#{service}")
      Config.raw ? response : format(response)
    end

    def get_comments
      response = Transceiver.new("/issues/#{@query.number.to_s}/comments", ssl: true).get
    end

    def get_issues
      Transceiver.new("/issues#{'/' + @query.number.to_s if @query.number }#{'?' + @query.elements.join('&') if not @query.elements.empty?}", ssl: true).get
    end

    def format(records)
      records.is_a?(Array) ? records.map { |r| GHService.new(r) } : GHService.new(records)
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
