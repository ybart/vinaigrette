require 'vinaigrette/model/serialization'
require 'vinaigrette/model/belongs_to'
require 'vinaigrette/model/accessor'

class Vinaigrette::Base
  include ActiveModel::Validations

  include Vinaigrette::Model::Serialization
  include Vinaigrette::Model::BelongsTo
  include Vinaigrette::Model::Accessor

  def initialize attributes = {}
    initialize_attributes attributes
    initialize_association_cache
  end

  #include ActiveModel::Conversion
  #extend  ActiveModel::Naming
end