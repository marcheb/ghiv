module Ghiv
  class Transceiver
    require "json"
    require "net/https"
    require "uri"

    def initialize(request, options={})
      options = {ssl: false}.merge!(options)
      url = "#{API_URL}/#{Config.user}/#{Config.repository}"

      @uri = URI.parse(URI.escape(url+request))
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true if options[:ssl]
    end

    def get
      request = Net::HTTP::Get.new(@uri.request_uri)
      request.basic_auth Config.user, Config.password

      response = @http.request(request)
      return response.code == "200" ? JSON.parse(response.body) : raise({ errors: { code: response.code, body: response.body }}.inspect)
    end
  end
end
