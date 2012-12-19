require_relative '../../test_helper'
require 'mocha/setup'

describe Sausage::Serialize do
  before do
    Object.send(:remove_const, :DeliciousSausage) if Object.const_defined?(:DeliciousSausage)
    Object.send(:remove_const, :SalmonDish) if Object.const_defined?(:SalmonDish)

    class DeliciousSausage
      def initialize attributes={}
      end
    end
    class SalmonDish
      include Sausage::Serialize
    end

    # Mock an ActiveRecord object with validations
    SalmonDish.stubs(:serialize)
    SalmonDish.stubs(:before_validation)
  end

  it 'should call successfully sausage_serialize method' do
    SalmonDish.send(:sausage_serialize, :sauce, DeliciousSausage)
  end

  it 'should call serialize with Hash' do
    SalmonDish.expects(:serialize).with(:sauce, Hash).once
    SalmonDish.send(:sausage_serialize, :sauce, DeliciousSausage)
  end

  it 'should add errors to outer model' do
    SalmonDish.send(:attr_accessor, :sauce)
    SalmonDish.send(:sausage_serialize, :sauce, DeliciousSausage)

    dish = SalmonDish.new
    dish.stubs(:attributes).returns({})

    sauce = DeliciousSausage.new
    sauce.stubs(:valid?).returns(false)
    sauce.stubs(:errors).returns([[:taste, 'should be delicious']])
    DeliciousSausage.stubs(:new).returns(sauce)

    error_mock = mock()
    error_mock.stubs(:add).with(:sauce, 'taste should be delicious').once
    dish.stubs(:errors).returns(error_mock)

    dish.__validate_sauce
  end

  it 'should override default Hash accessor' do
    SalmonDish.send(:attr_accessor, :sauce)
    SalmonDish.send(:sausage_serialize, :sauce, DeliciousSausage)

    dish = SalmonDish.new
    dish.stubs(:attributes).returns({})

    assert_equal(DeliciousSausage, dish.sauce.class)
  end
end