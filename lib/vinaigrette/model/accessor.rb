# Support for casting string to boolean
module Kernel
  def Boolean(string)
    return true if string== true || string =~ (/^(true|t|yes|y|1)$/i)
    return false if string== false || string.nil? || string =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end
end

module Vinaigrette::Model
  module Accessor
    extend ActiveSupport::Concern

    module ClassMethods
      def vinaigrette_accessor(accessor, type, default = nil)
        supported_attributes = instance_variable_get("@supported_attributes") || []
        supported_attributes.push accessor
        instance_variable_set("@supported_attributes", supported_attributes)

        @attributes_names ||= []
        @attributes_names.push accessor

        define_method(accessor) do
          instance_variable_get("@#{accessor}")
        end

        define_method("reset_#{accessor}") do
          value = default.kind_of?(Proc) ? default.call : default
          instance_variable_set("@#{accessor}", value)
        end

        define_method("#{accessor}=") do |val|
          if !val.nil?
            begin
              value = Kernel.send(type.to_s, val)
              instance_variable_set("@#{accessor}", value)
            rescue Exception => e
              send("reset_#{accessor}")
            end
          else
            send("reset_#{accessor}")
          end
        end
      end
    end
  end
end
