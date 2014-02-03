module CGMiner
  module API

    class Response

      attr_reader :status

      attr_reader :body

      attr_reader :raw

      def initialize(command_symbol, raw_command_response)
        @raw = JSON.parse(raw_command_response)
        @status = @raw['STATUS'][0]
        @body = @raw[command_symbol.to_s.upcase]
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
