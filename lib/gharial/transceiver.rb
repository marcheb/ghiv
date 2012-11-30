module Gharial
  class Transceiver
    require "json"
    require "net/https"
    require "uri"

    Configs.load!(File.expand_path(File.dirname(__FILE__)) + '/../../config/config.yml')

    def initialize(request, options={})
      options = {ssl: false}.merge!(options)
      url = "#{Configs.github[:api_url]}/#{Configs.github[:user]}/#{Configs.github[:repository]}"

      @uri = URI.parse(url+request)
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true if options[:ssl]
    end

    def get
      request = Net::HTTP::Get.new(@uri.request_uri)
      request.basic_auth Configs.github[:user], Configs.github[:password]

      response = @http.request(request)
      return response.code == "200" ? JSON.parse(response.body) : raise({ errors: { code: response.code, body: response.body }}.inspect)
    end
  end
end
