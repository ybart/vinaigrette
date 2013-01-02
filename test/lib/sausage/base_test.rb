require_relative '../../test_helper'

describe Sausage::Base do
  before do
    Object.send(:remove_const, :DeliciousSausage) if Object.const_defined?(:DeliciousSausage)
    class DeliciousSausage < Sausage::Base; end
  end

  it 'should be able to use active model validations' do
    DeliciousSausage.must_respond_to(:validates)
  end

  it 'should allow using belongs_to associations' do
    DeliciousSausage.must_respond_to(:belongs_to)
  end

  it 'should have required active_record dependencies' do
    klass = Class.new(Sausage::Base) do
      attr_accessor :recipe_id
      belongs_to :recipe
    end
    Object.const_set(:AnethSauce, klass)

    klass = Class.new(ActiveRecord::Base)
    Object.const_set(:Recipe, klass)

    assert_respond_to(AnethSauce, :compute_type)

    sauce = AnethSauce.new
    assert_respond_to(sauce, :autosave_associated_records_for_recipe)
    assert_respond_to(sauce, :recipe)
    sauce.recipe
  end

  it 'should actually search the associated record' do
    # TODO: Find a way to test this
  end

  it 'should serialize its attributes' do
    DeliciousSausage.send(:attr_accessor, :recipe_id)
    sauce = DeliciousSausage.new

    assert_equal({recipe_id: nil}, sauce.serializable_hash)

    sauce.recipe_id = 42
    assert_equal({recipe_id: 42}, sauce.serializable_hash)

    sauce.recipe_id = "MyRecipe"
    assert_equal({recipe_id: "MyRecipe"}, sauce.serializable_hash)
  end

  it 'should support sausage_accessor' do
    DeliciousSausage.send(:sausage_accessor, :recipe_id, Integer)
    sauce = DeliciousSausage.new

    sauce.recipe_id = "42"
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support default values' do
    DeliciousSausage.send(:sausage_accessor, :recipe_id, Integer, 42)
    sauce = DeliciousSausage.new
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support invalid casts' do
    DeliciousSausage.send(:sausage_accessor, :recipe_id, Integer, 42)
    sauce = DeliciousSausage.new
    sauce.recipe_id = false
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support default values' do
    DeliciousSausage.send(:sausage_accessor, :name, String, "")
    sauce = DeliciousSausage.new
    sauce.name = nil
    assert_equal({name: ""}, sauce.serializable_hash)
  end

  it 'should support boolean values' do
    DeliciousSausage.send(:sausage_accessor, :has_recipe, 'Boolean', nil)
    sauce = DeliciousSausage.new

    assert_equal({has_recipe: nil}, sauce.serializable_hash)
    sauce.has_recipe = false
    assert_equal({has_recipe: false}, sauce.serializable_hash)
  end

  it 'should fail casting invalid booleans' do
    assert_raises ArgumentError do
      Kernel.Boolean("should not become a boolean")
    end
  end

  it 'should cast valid booleans' do
    assert_equal(false, Kernel.Boolean("false"))
    assert_equal(false, Kernel.Boolean("no"))
    assert_equal(false, Kernel.Boolean("0"))
    assert_equal(true, Kernel.Boolean("true"))
    assert_equal(true, Kernel.Boolean("yes"))
    assert_equal(true, Kernel.Boolean("1"))
  end

  it 'should support procs' do
    DeliciousSausage.send(:sausage_accessor, :recipe_id, Integer, lambda { 42 })

    sauce = DeliciousSausage.new
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end
end