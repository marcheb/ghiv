module Gharial
  class Issues < GithubMapper
    def self.fields
      ['url', 'html_url', 'number', 'state', 'title', 'body']
    end
  end
end
