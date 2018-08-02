class Exception
  class Auth
    class InvalidCredentials < StandardError
      def initialize(msg = 'invalid credentials')
        super
      end
    end

    class MissingToken < StandardError
      def initialize(msg = 'missing token')
        super
      end
    end

    class InvalidToken < StandardError
      def initialize(msg = 'invalid token')
        super
      end
    end
  end
end