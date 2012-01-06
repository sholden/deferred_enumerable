require "test/unit"
require 'deferred_enumerable'

class EnumerableExtensionTest < Test::Unit::TestCase
  def setup
    @enumerable = [:a, :b, :c]
  end

  def test_defer_should_return_recorder
    recorder = @enumerable.defer
    assert_kind_of DeferredEnumerable::Recorder, recorder
  end
end