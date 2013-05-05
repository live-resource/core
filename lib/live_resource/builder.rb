require "live_resource/resource"

module LiveResource
  class Builder
    attr_reader :resource

    def initialize(resource_name)
      @resource_class = Class.new(Resource) # This creates a dynamic subclass of Resource
      @resource = @resource_class.new(resource_name)
    end

    def depends_on(target, *events, &block)
      resource.depends_on(target, events, block)
    end

    def method_name
      :"#{@resource.name}_resource"
    end

    def identifier(&block)
      @identifier_proc = block

      @resource_class.class_eval do
        #include Rails.application.routes.url_helpers
        define_method(:identifier, &block)
      end
    end

    def resource_method
      resource = @resource
      Proc.new { resource }
    end
  end
end