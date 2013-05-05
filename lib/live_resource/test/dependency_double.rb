module LiveResource
  module Test

    class DependencyDouble < LiveResource::Dependency

      def self.accepts_target?(anything)
        true
      end

      def watch
        @watching = true
      end

      def watching?
        !!@watching
      end

    end

  end
end