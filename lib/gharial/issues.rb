module Gharial
  class Issues < Base
    def self.fields
      ['body', 'created_at', 'html_url', 'number', 'state', 'title', 'url']
    end
  end
end
