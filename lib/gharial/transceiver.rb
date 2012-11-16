module Gharial
  class Transceiver
    require "json"
    require "net/https"
    require "uri"

    Gharial::Configs.load!(File.expand_path(File.dirname(__FILE__)) + '/../../config/config.yml')

    def initialize(url, options={})
      options = {ssl: false}.merge!(options)

      @uri = URI.parse(url)
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true if options[:ssl]
    end

    def get
      request = Net::HTTP::Get.new(@uri.request_uri)
      request.basic_auth Gharial::Configs.github[:user], Gharial::Configs.github[:password]
      response = @http.request(request)
      return response.code == "200" ? JSON.parse(response.body) : raise({ errors: { code: response.code, body: response.body }}.inspect)
    end
  end
end
