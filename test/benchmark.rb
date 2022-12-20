# frozen_string_literal: true

require 'test_helper'

class WisconsinBenchmarkTest < Test::Unit::TestCase
  include WisconsinBenchmark

  test 'VERSION' do
    assert do
      ::WisconsinBenchmark.const_defined?(:VERSION)
    end
  end

  sub_test_case 'array' do
    test 'something useful' do
      assert_kind_of? Numo::UInt32, WisconsinBenchmark::Array.new
      assert_raise(RuntimeError) { WisconsinBenchmark::Array.new(1E9.to_i) }
    end
  end
end
