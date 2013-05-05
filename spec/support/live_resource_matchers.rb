module LiveResourceMatchers
  # Tests that a LiveResource::Resource has a dependency on the given target, optionally for the given events.
  class DependOn
    def initialize(target)
      @target = target
    end

    def matches?(live_resource)
      @live_resource = live_resource

      @actual_targets = @live_resource.dependencies.map { |dependency| dependency.target }

      return @actual_targets.include?(@target)
    end

    def failure_message
      "expected '#{@live_resource.name}' resource to depend on #{@target.inspect} but it instead depended on #{@actual_targets}"
    end

    def negative_failure_message
      "expected '#{@live_resource.name}' resource not to depend on #{@target.inspect} but it instead depended on #{@actual_targets}"
    end

    def description
      "depend on #{@target.inspect}"
    end

    def for_events(*events)
      @for_events = events
      self
    end
  end

  def depend_on(expected)
    DependOn.new(expected)
  end

end
