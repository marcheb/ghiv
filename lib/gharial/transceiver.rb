module Gharial
  class Transceiver
    require "json"
    require "net/https"
    require "uri"

    def initialize(url, options={})
      options = {ssl: false}.merge!(options)

      @uri = URI.parse(url)
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true if options[:ssl]
    end

    def get
      request = Net::HTTP::Get.new(@uri.request_uri)
      response = @http.request(request)
      return response.code == "200" ? JSON.parse(response.body) : raise({ errors: { code: response.code, body: response.body }}.inspect)
    end
  end
end
