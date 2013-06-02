module LiveResource

  # Protocols are used by the Resource class to notify people interested in the resource that something's happened.
  # This module defines the public behaviour of a protocol, in terms of the internal method #publish_message.
  #
  # Protocol classes must implement the #publish_message and #encode_identifier methods.
  #  - #publish_message(resource_id, message) publishes `message` to the resource matching the identifier (where
  #    message is a hash)
  #  - #encode_identifier(resource_id) transforms an identifier string as appropriate for the protocol (e.g.
  #    sanitizing unsafe characters or obfuscating the actual resource ID)
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