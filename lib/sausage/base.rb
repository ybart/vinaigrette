require 'sausage/model/serialization'
require 'sausage/model/belongs_to'
require 'sausage/model/accessor'

class Sausage::Base
  include ActiveModel::Validations

  include Sausage::Model::Serialization
  include Sausage::Model::BelongsTo
  include Sausage::Model::Accessor

  def initialize attributes = {}
    initialize_attributes attributes
    initialize_association_cache
  end

  #include ActiveModel::Conversion
  #extend  ActiveModel::Naming
end