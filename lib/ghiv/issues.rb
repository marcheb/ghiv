module Ghiv
  class Issues
    attr_accessor :body, :comments, :created_at, :html_url, :labels, :milestone, :number, :state, :title, :url

    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}", v) if respond_to? k }
    end
  end
end
