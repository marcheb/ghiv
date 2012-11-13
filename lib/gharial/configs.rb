# http://speakmy.name/2011/05/29/simple-configuration-for-ruby-apps/
# deep_symbolize at https://gist.github.com/3706025
module Gharial
  module Configs
    require 'yaml'
    extend self

    @_configs = {}
    attr_reader :_configs

    def load!(filename, options = {})
      newsets = YAML::load_file(filename)
      deep_merge!(@_configs, newsets)
    end

    # Deep merging of hashes
    # deep_merge by Stefan Rusterholz, see http://www.ruby-forum.com/topic/142809
    def deep_merge!(target, data)
      merger = proc{|key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      target.merge! data, &merger
    end

    def method_missing(name, *args, &block)
      @_configs[name.to_sym] || fail(NoMethodError, "unknown configuration root #{name}", caller)
    end
  end
end
