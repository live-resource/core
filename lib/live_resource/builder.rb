require "live_resource/resource"

module LiveResource
  class Builder
    attr_reader :resource

    def initialize(resource_name, protocol, dependency_types)
      @dependency_types = dependency_types
      @resource_class   = Class.new(Resource) # This creates an anonymous subclass of Resource
      @resource         = @resource_class.new(resource_name, protocol)
    end

    def depends_on(target, *args, &block)
      dependency_type = first_dependency_type_accepting(target)
      raise "No dependency type is registered that accepts #{target.inspect}" unless dependency_type

      dependency = dependency_type.new(@resource, target, block, *args)
      @resource.dependencies << dependency
    end

    def identifier(&block)
      @identifier_proc = block

      @resource_class.class_eval do
        define_method(:identifier, &block)
      end
    end

    private

    def first_dependency_type_accepting(target)
      @dependency_types.each { |type| return type if type.accepts_target? target }
      nil
    end
  end
end