module Ghiv::MethodChain
  def chained_attr_accessor(*attr_names)
    attr_names.each do |attr_name|
      define_method :"#{attr_name}" do | *args |
        return case args.length
        when 0 then instance_variable_get(:"@#{attr_name}")
        when 1 then instance_variable_set(:"@#{attr_name}", args[0]) and self
        else raise ArgumentError.new("wrong number of arguments (#{args.length} for 1)")
        end
      end
    end
  end
end
