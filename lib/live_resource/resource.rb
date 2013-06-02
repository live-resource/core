module LiveResource
  class Resource

    attr_reader :name, :dependencies

    def initialize(name, protocol)
      @name         = name
      @protocol     = protocol
      @dependencies = []
    end

    def identifier(*context)
      raise "You must define an identifier method for the resource '#{@name}'" unless respond_to?(:_identifier)
      raw_identifier = _identifier(*context)
      @protocol.encode_identifier(raw_identifier)
    end

    def push(*context)
      @protocol.publish_resource_reset(identifier(*context))
    end

  end
end