module LiveResource
  module Protocol

    def publish_resource_reset(identifier)
      publish_message(identifier, 'resource:reset')
    end

    def publish_property_change(identifier, property, value)
      publish_message(identifier, 'resource:property:change', {
          property: property,
          value: value
      })
    end

    def publish_collection_insert(identifier, property, element)
      publish_message(identifier, 'resource:collection:insert', {
          property: property,
          element: element
      })
    end

    def publish_collection_remove(identifier, property, element)
      publish_message(identifier, 'resource:collection:remove', {
          property: property,
          element: element
      })
    end

  end
end