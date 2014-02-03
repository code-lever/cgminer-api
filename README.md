# CGMiner::API  [![Build Status](https://travis-ci.org/code-lever/cgminer-api.png)](https://travis-ci.org/code-lever/cgminer-api) [![Dependency Status](https://gemnasium.com/code-lever/cgminer-api.png)](https://gemnasium.com/code-lever/cgminer-api) [![Code Climate](https://codeclimate.com/github/code-lever/cgminer-api.png)](https://codeclimate.com/github/code-lever/cgminer-api)

A pretty basic Ruby gem to use to interact with a CGMiner (or compatible) Bitcoin/Litecoin mining application.

## Installation

Add this line to your application's Gemfile:

    gem 'cgminer-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cgminer-api

## Usage

    client = CGMiner::API::Client.new('localhost', 4028)
    client.version
      => #<CGMiner::API::Response:0x000001011109c0
           @status={"STATUS"=>"S", "When"=>1391460011, "Code"=>22,
                    "Msg"=>"CGMiner versions", "Description"=>"cgminer 3.7.2"},
           @body=[{"CGMiner"=>"3.7.2", "API"=>"1.32"}]>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
