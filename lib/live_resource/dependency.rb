module LiveResource

  class Dependency
    attr_reader :events

    def initialize(resource, events, block)
      @resource = resource
      @proc     = block
      @events   = events
    end

    def invoke(event, *context)
      case @proc.arity
        when 0
          @proc.bind(@resource).call()
        when context.length
          @proc.bind(@resource).call(*context)
        else
          context.push(event)
          @proc.bind(@resource).call(*context)
      end
    end

    def watch
      @events.each do |event|
        observe(event)
      end
    end

    def watching?(events)
      @events == events
    end
  end

end