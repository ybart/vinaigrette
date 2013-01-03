require_relative '../../test_helper'

describe Vinaigrette do
  it "must be defined" do
    Vinaigrette::VERSION.wont_be_nil
  end
end