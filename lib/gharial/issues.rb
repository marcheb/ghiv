module Gharial
  class Issues < Base
    def self.fields
      ['url', 'html_url', 'number', 'state', 'title', 'body']
    end
  end
end
