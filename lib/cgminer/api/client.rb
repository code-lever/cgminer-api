module CGMiner
  module API

    class Client

      def initialize(host, port)
        @host = host
        @port = port
      end

      def devs
        command(:devs)
      end

      def pools
        command(:pools)
      end

      def summary
        command(:summary)
      end

      def version
        command(:version)
      end

      private

      def command(symbol)
        api = Net::Telnet::new('Host' => @host, 'Port' => @port)
        results = api.cmd({ command: symbol.to_s }.to_json)

        begin
          json = JSON.parse(results)
          status = json['STATUS'][0]
          reply = json[symbol.to_s.upcase]
          response = CGMiner::API::Response.new(status, reply)
        rescue JSON::ParserError => e
          raise RuntimeError, "Failed parsing response: #{e}"
        end
      end

    end

  end
end
