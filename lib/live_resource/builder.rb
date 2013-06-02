require "live_resource/resource"

module LiveResource
  class Builder
    attr_reader :resource

    def initialize(resource_name, protocol, dependency_types, extensions = nil)
      @dependency_types = dependency_types
      @resource_class   = Class.new(Resource) do # This creates an anonymous subclass of Resource
        include extensions if extensions
      end
      @resource         = @resource_class.new(resource_name, protocol)
    end

    def depends_on(target, *args, &block)
      dependency_type = first_dependency_type_accepting(target)

      unless dependency_type
        raise <<-EOF
No dependency type is registered that accepts #{target.inspect}
Registered dependency types are: #{@dependency_types.inspect}
        EOF
      end

      dependency = dependency_type.new(@resource, target, block, *args)
      @resource.dependencies << dependency
    end

    def identifier(&block)
      @identifier_proc = block

      @resource_class.class_eval do
        define_method(:_identifier, &block)
      end
    end

    private

    def first_dependency_type_accepting(target)
      @dependency_types.each { |type| return type if type.accepts_target? target }
      nil
    end
  end
end