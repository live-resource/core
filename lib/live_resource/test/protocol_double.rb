module LiveResource
  module Test

    class ProtocolDouble
      include LiveResource::Protocol

      attr_reader :messages

      def initialize
        @messages = []
      end

      private

      def publish_message(resource_identifier, message_type, params = nil)
        params  ||= {}
        message = params.merge({
                                   :type         => message_type,
                                   ':resource_id' => resource_identifier
                               })
        @messages << message
      end
    end

  end
end