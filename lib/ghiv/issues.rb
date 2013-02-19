module Ghiv
  class Issues
    attr_accessor :body, :created_at, :html_url, :number, :state, :title, :url

    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}", v) if respond_to? k }
    end
  end
end
