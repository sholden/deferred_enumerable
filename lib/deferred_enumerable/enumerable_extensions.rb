module Enumerable
  def defer
    DeferredEnumerable::Recorder.new(self)
  end
end