require "railroad/switch/version"

module Railroad
  module Switch
    class << self
      attr_reader :route
      attr_accessor :fallback_to

      def app
        Application.new
      end

      def register(path:, app:)
        @route ||= {}
        @route[path] = app
      end
    end

    class Application
      def call(env)
        app = Railroad::Switch.route&.fetch(env['PATH_INFO'], nil)

        if app
          app.call(env)
        elsif Railroad::Switch.fallback_to
          Railroad::Switch.fallback_to.call(env)
        else
          [404, { "X-Cascade" => "pass" }, []]
        end
      end
    end
  end
end
