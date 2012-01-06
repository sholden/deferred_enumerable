module Enumerable
  def defer
    DeferredEnumerable::Recorder.new(self)
  end
end

if defined? ActiveRecord::Relation
  module ActiveRecord
    class Relation
      def defer
        DeferredEnumerable::Recorder.new(self)
      end
    end
  end
end