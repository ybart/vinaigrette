module Vinaigrette::Model
  module BelongsTo
    extend ActiveSupport::Concern

    included do
      include ActiveRecord::Associations
      include ActiveRecord::Reflection          # belongs_to uses create_reflection

      # Used when fetching an actual record
      include ActiveRecord::Inheritance         # association calls use compute_type
      include ActiveRecord::AutosaveAssociation # add_autosave_association_callback
      include ActiveRecord::Callbacks           # add_autosave_association_callback
    end

    # Associations calls [] to retrieve attributes.
    def [] name
      attributes[name.to_sym]
    end

    # association_cache is assumed to exist by ActiveRecord::Associations
    def initialize_association_cache
      @association_cache = {}
    end

    module ClassMethods
      # Reflection initialization uses pluralize_table_names
      def pluralize_table_names
        false
      end

      # generated_feature_methods is used when building the association
      def generated_feature_methods
        @generated_feature_methods ||= begin
          mod = const_set(:GeneratedFeatureMethods, Module.new)
          include mod
          mod
        end
      end
    end
  end
end
