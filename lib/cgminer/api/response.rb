module CGMiner
  module API

    class Response

      attr_reader :status

      attr_reader :body

      def initialize(status, body)
        @status = status
        @body = body
      end

      def received_at
        DateTime.strptime("#{@status['When']}", '%s')
      end

      def success?
        @status['STATUS'] == 'S'
      end

    end

  end
end
