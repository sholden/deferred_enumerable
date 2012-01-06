require "deferred_enumerable/version"
require 'deferred_enumerable/recorder'
require 'deferred_enumerable/deferrable'

module DeferredEnumerable

end

module Enumerable
  include Deferrable
end

if defined? ActiveRecord::Relation
  module ActiveRecord
    class Relation
      include Deferrable
    end
  end
end