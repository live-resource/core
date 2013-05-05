module LiveResource

  class Dependency
    def initialize(resource, proc)
      @resource = resource
      @proc     = proc
    end

    def invoke(*context)
      @proc.bind(@resource).call(*context)
    end

    def watch
      raise "Implement this method in a subclass, use it to set up hooks etc."
    end
  end

end