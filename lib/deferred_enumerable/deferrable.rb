module Deferrable
  def defer
    DeferredEnumerable::Recorder.new(self)
  end
end