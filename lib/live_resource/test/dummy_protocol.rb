module LiveResource
  class DummyProtocol
    include LiveResource::Protocol

    attr_accessor :messages

    def initialize
      @messages = []
    end

    private

    def publish_message(type, params, *context)
      message = params.merge({
                                 :type           => type,
                                 :':resource_id' => resource_id,
                             })

      @messages << message
    end
  end
end