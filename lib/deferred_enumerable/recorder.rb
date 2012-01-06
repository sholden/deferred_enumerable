module DeferredEnumerable
  class Recorder
    attr_reader :target_object, :finalized_object, :recorded_calls
    DEFERRABLE_METHODS = [:to_a, :entries, :sort, :sort_by, :grep, :find_all, :select, :reject, :collect, :map,
                          :flat_map, :partition, :group_by, :zip, :take, :take_while, :drop, :drop_while]

    def initialize(target_object)
      @target_object  = target_object
      @recorded_calls = []
    end

    def finalize!
      @finalized_object = playback_calls
    end

    def finalized?
      defined? @finalized_object
    end

    def playback_calls
      recorded_calls.inject(@target_object) do |target, call|
        method, args, block = call
        forward_call(target, method, args, block)
      end
    end

    def record_call(method, args, block)
      recorded_calls << [method, args, block]
    end

    def forward_call(target, method, args, block)
      if block
        target.send(method, *args, &block)
      else
        target.send(method, *args)
      end
    end

    def respond_to?(method)
      super(method) || @target_object.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      if @target_object.respond_to?(method)
        if is_deferrable?(method.to_sym)
          record_call method, args, block
          self
        else
          finalize! unless finalized?
          forward_call(finalized_object, method, args, block)
        end
      else
        super
      end
    end

    def is_deferrable?(method)
      !finalized? && DEFERRABLE_METHODS.include?(method)
    end
  end
end