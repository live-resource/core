module LiveResource
  module Protocol
    def publish_resource_reset(*context)
      publish_message('resource:reset', {}, *context)
    end

    def publish_property_change(property, value, *context)
      publish_message('resource:property:change', {
          property: property,
          value: value
      }, *context)
    end

    def publish_collection_insert(property, element, *context)
      publish_message('resource:collection:insert', {
          property: property,
          element: element
      }, *context)
    end

    def publish_collection_remove(property, element, *context)
      publish_message('resource:collection:remove', {
          property: property,
          element: element
      }, *context)
    end

    private

    #def publish_message(type, params, *context)
    #  channel_id = resource_id = identifier(*context)
    #
    #  message = params.merge({
    #      :type           => type,
    #      :':resource_id' => resource_id,
    #  })
    #
    #  Rails.logger.debug("LiveResource::Protocol#publish type='#{type}', channel_id='#{channel_id}'")
    #  Rails.logger.debug(message.inspect)
    #
    #  PubnubHelper.publish(channel_id, message)
    #end
  end
end