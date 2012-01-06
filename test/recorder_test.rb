require "test/unit"
require 'deferred_enumerable'

class RecorderTest < Test::Unit::TestCase
  def setup
    @target_object = [:a, :b, :c]
    @recorder      = DeferredEnumerable::Recorder.new(@target_object)
  end

  def test_should_have_target_object
    assert_equal @recorder.target_object, @target_object
  end

  def test_should_report_respond_to
    assert @recorder.respond_to? :each
    assert @recorder.respond_to? :map
    assert !@recorder.respond_to?(:fake)
  end

  def test_should_invoke_when_non_deferrable
    first_element = @recorder.first
    assert_equal 0, @recorder.recorded_calls.length
    assert_equal :a, first_element
    assert @recorder.finalized?
  end

  def test_should_defer_single_call
    @recorder.map{|sym| sym.to_s}
    assert_equal 1, @recorder.recorded_calls.length
    assert !@recorder.finalized?
  end

  def test_should_defer_multiple_calls
    @recorder.map(&:to_s).select{|str| str =~ /b/}
    assert_equal 2, @recorder.recorded_calls.length
    assert !@recorder.finalized?
  end

  def test_should_finalize_after_non_deferrable_call
    @recorder.map(&:to_s).select{|str| str =~ /b/}
    result = @recorder.first
    assert_equal 'b', result
    assert_equal 2, @recorder.recorded_calls.length
    assert @recorder.finalized?
  end
end