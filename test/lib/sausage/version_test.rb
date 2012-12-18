require_relative '../../test_helper'

describe Sausage do
  it "must be defined" do
    Sausage::VERSION.wont_be_nil
  end
end