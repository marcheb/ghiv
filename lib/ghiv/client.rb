module Ghiv
  class Client
    attr_reader :service

    def initialize(service)
      @service = service
    end

    def get
      query = eval("Query::#{@service.to_s.capitalize}").new.build
      Transceiver.new(query, ssl: true).get
    end
  end
end
