require 'active_model'

module Sausage::Serialize
  extend ActiveSupport::Concern

  module ClassMethods
    def sausage_serialize attribute_name, klass
      validation_method = "__validate_#{attribute_name}".to_sym
      accessor_method = attribute_name.to_sym

      send(:serialize, attribute_name, Hash)
      send(:before_validation, validation_method)

      define_method accessor_method do
        klass.new(attributes[attribute_name.to_s])
      end

      define_method validation_method do
        options = klass.new(attributes[attribute_name.to_s])
        options.valid?
        options.errors.each do |field, message|
          errors.add(attribute_name.to_sym, "#{field} #{message}")
        end
      end
    end
  end
end