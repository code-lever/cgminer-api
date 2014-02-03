module CGMiner
  module API

    class Client

      def initialize(host, port)
        @host = host
        @port = port
      end

      def asc(index)
        command(:asc, index)
      end

      def asccount
        command(:asccount)
      end

      # @param command [Symbol] the command to check
      def check(command)
        command(:check, command)
      end

      def coin
        command(:coin)
      end

      def config
        command(:config)
      end

      def devdetails
        command(:devdetails)
      end

      def devs
        command(:devs)
      end

      def gpu(index)
        command(:gpu, index)
      end

      def gpucount
        command(:gpucount)
      end

      def pga(index)
        command(:pga, index)
      end

      def pgacount
        command(:pgacount)
      end

      def pools
        command(:pools)
      end

      def stats
        command(:stats)
      end

      def summary
        command(:summary)
      end

      def usbstats
        command(:usbstats)
      end

      def version
        command(:version)
      end

      private

      def command(symbol, *parameters)
        api = Net::Telnet::new('Host' => @host, 'Port' => @port)
        results = api.cmd({ command: symbol.to_s, parameter: parameters.join(',') }.to_json)

        begin
          response = CGMiner::API::Response.new(symbol, JSON.parse(results))
        rescue JSON::ParserError => e
          raise RuntimeError, "Failed parsing response: #{e}"
        end
      ensure
        api.close unless api.nil?
      end

    end

  end
end
