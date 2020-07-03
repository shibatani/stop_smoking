# frozen_string_literal: true

require 'test_helper'

class SmokerDecoratorTest < ActiveSupport::TestCase
  def setup
    @smoker = Smoker.new.extend SmokerDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
