module CGMiner
  module API

    class Response

      attr_reader :status

      attr_reader :body

      def initialize(command_symbol, command_response)
        json = JSON.parse(command_response)
        @status = json['STATUS'][0]
        @body = json[command_symbol.to_s.upcase]
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
