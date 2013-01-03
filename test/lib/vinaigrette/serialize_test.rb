require_relative '../../test_helper'

describe Vinaigrette::Serialize do
  before do
    Object.send(:remove_const, :DeliciousSauce) if Object.const_defined?(:DeliciousSauce)
    Object.send(:remove_const, :SalmonDish) if Object.const_defined?(:SalmonDish)

    class DeliciousSauce
      def initialize attributes={}
      end
    end
    class SalmonDish
      include Vinaigrette::Serialize
    end

    # Mock an ActiveRecord object with validations
    SalmonDish.stubs(:serialize)
    SalmonDish.stubs(:before_validation)
  end

  it 'should call successfully vinaigrette_serialize method' do
    SalmonDish.send(:vinaigrette_serialize, :sauce, DeliciousSauce)
  end

  it 'should call serialize with Hash' do
    SalmonDish.expects(:serialize).with(:sauce, Hash).once
    SalmonDish.send(:vinaigrette_serialize, :sauce, DeliciousSauce)
  end

  it 'should add errors to outer model' do
    SalmonDish.send(:attr_accessor, :sauce)
    SalmonDish.send(:vinaigrette_serialize, :sauce, DeliciousSauce)

    dish = SalmonDish.new
    dish.stubs(:attributes).returns({})

    sauce = DeliciousSauce.new
    sauce.stubs(:valid?).returns(false)
    sauce.stubs(:errors).returns([[:taste, 'should be delicious']])
    DeliciousSauce.stubs(:new).returns(sauce)

    error_mock = mock()
    error_mock.stubs(:add).with(:sauce, 'taste should be delicious').once
    dish.stubs(:errors).returns(error_mock)

    dish.__validate_sauce
  end

  it 'should override default Hash accessor' do
    SalmonDish.send(:attr_accessor, :sauce)
    SalmonDish.send(:vinaigrette_serialize, :sauce, DeliciousSauce)

    dish = SalmonDish.new
    dish.stubs(:attributes).returns({})

    assert_equal(DeliciousSauce, dish.sauce.class)
  end
end