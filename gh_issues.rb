class GhIssues
  require "json"
  require "net/https"
  require "uri"

  def self.all
    uri = URI.parse("https://api.github.com/repos/marcheb/sample-issues-for-gh-free-issues/issues?state=open")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    JSON.parse response.body
  end
end
