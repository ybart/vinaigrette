require_relative '../../test_helper'

describe Vinaigrette::Base do
  before do
    Object.send(:remove_const, :DeliciousSauce) if Object.const_defined?(:DeliciousSauce)
    class DeliciousSauce < Vinaigrette::Base; end
  end

  it 'should be able to use active model validations' do
    DeliciousSauce.must_respond_to(:validates)
  end

  it 'should allow using belongs_to associations' do
    DeliciousSauce.must_respond_to(:belongs_to)
  end

  it 'should have required active_record dependencies' do
    klass = Class.new(Vinaigrette::Base) do
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
    DeliciousSauce.send(:attr_accessor, :recipe_id)
    sauce = DeliciousSauce.new

    assert_equal({recipe_id: nil}, sauce.serializable_hash)

    sauce.recipe_id = 42
    assert_equal({recipe_id: 42}, sauce.serializable_hash)

    sauce.recipe_id = "MyRecipe"
    assert_equal({recipe_id: "MyRecipe"}, sauce.serializable_hash)
  end

  it 'should support access by name (needed by belongs_to)' do
    DeliciousSauce.send(:attr_accessor, :recipe_id)
    sauce = DeliciousSauce.new
    sauce.recipe_id = 42
    assert_equal(42, sauce[:recipe_id])
    assert_equal(42, sauce['recipe_id'])
  end

  it 'should support vinaigrette_accessor' do
    DeliciousSauce.send(:vinaigrette_accessor, :recipe_id, Integer)
    sauce = DeliciousSauce.new

    sauce.recipe_id = "42"
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support default values' do
    DeliciousSauce.send(:vinaigrette_accessor, :recipe_id, Integer, 42)
    sauce = DeliciousSauce.new
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support invalid casts' do
    DeliciousSauce.send(:vinaigrette_accessor, :recipe_id, Integer, 42)
    sauce = DeliciousSauce.new
    sauce.recipe_id = false
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end

  it 'should support default values' do
    DeliciousSauce.send(:vinaigrette_accessor, :name, String, "")
    sauce = DeliciousSauce.new
    sauce.name = nil
    assert_equal({name: ""}, sauce.serializable_hash)
  end

  it 'should support boolean values' do
    DeliciousSauce.send(:vinaigrette_accessor, :has_recipe, 'Boolean', nil)
    sauce = DeliciousSauce.new

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
    DeliciousSauce.send(:vinaigrette_accessor, :recipe_id, Integer, lambda { 42 })

    sauce = DeliciousSauce.new
    assert_equal({recipe_id: 42}, sauce.serializable_hash)
  end
end