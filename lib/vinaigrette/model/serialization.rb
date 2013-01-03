module Vinaigrette::Model
  module Serialization
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Serializers::JSON
    end

    def initialize_attributes attributes
      self.class.attributes_names.each do |k|
        reset_method = "reset_#{k}".to_sym
        send(reset_method) if respond_to?(reset_method)
      end

      attributes.each { |k,v| send("#{k}=".to_sym, v) }
    end

    def attributes
      Hash[self.class.attributes_names.map { |name| [name, send(name)] }]
    end

    module ClassMethods
      def attributes_names
        @attributes_names
      end

      def attr_accessor(*vars)
        @attributes_names ||= []
        @attributes_names.concat vars
        super(*vars)
      end
    end
  end
end