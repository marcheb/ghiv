module Gharial
  class Issues < Base

    def self.fields
      ['url', 'html_url', 'number', 'state', 'title', 'body']
    end

   # def self.creator(user_name)
   #   Gharial::Query.new('issues').creator(user_name)
   # end
   #
   # def self.labels(elements=[])
   #   Gharial::Query.new('issues').labels(elements)
   # end
  end
end
