module Ghiv
  module Config
    class << self
      require 'yaml'
      attr_accessor :in_stream, :password, :out_stream, :query_direction, :query_sort, :repository, :user

      def load!(filename, options = {})
        config = YAML::load_file(filename) if File.exists? filename and YAML::load_file(filename).is_a? Hash
        config.each { |k,v| instance_variable_set("@#{k}", v) if not instance_variable_get("@#{k}") } if config
      end
    end
  end
end
