module LiveResource

  class Dependency
    attr_reader :target

    def initialize(resource, target, proc)
      @resource = resource
      @proc     = proc
      @target   = target
    end

    def invoke(*context)
      @resource.instance_exec(*context, &@proc)
    end

    def watch
      raise "Implement this method in a subclass, use it to set up hooks etc."
    end
  end

end