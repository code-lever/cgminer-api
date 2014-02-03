require 'spec_helper'

describe CGMiner::API::Client do

  let(:host) { 'my-hostname' }

  let(:port) { 1234 }

  let(:telnet) do
    telnet = double('Net::Telnet')
  end

  before(:each) do
    stub_const 'Net::Telnet', double(new: telnet)
    @client = described_class.new(host, port)
  end

  subject { @client }

  context 'successful communication' do

    let(:reply) do
      <<-EOF
{"STATUS":[{"STATUS":"S","When":1391459548,"Code":78,"Msg":"CGMiner coin","Description":"cgminer 3.7.2"}],"COIN":[{"Hash Method":"scrypt","Current Block Time":1391457585.060405,"Current Block Hash":"0012a85cfa3d1b7cc00bf56a5c8cd283e8ca95995d040c42ff4c66f219e24567","LP":true,"Network Difficulty":10.87349847}],"id":1}
      EOF
    end

    before(:each) do
      telnet.stub(:cmd).and_return(reply)
      telnet.should_receive(:close)
    end

    its(:coin) { should be_a(CGMiner::API::Response) }

  end

  context 'with parameters' do

    let(:reply) do
      <<-EOF
{"STATUS":[{"STATUS":"S","When":1391459548,"Code":78,"Msg":"CGMiner coin","Description":"cgminer 3.7.2"}],"ASC":[{"Hash Method":"scrypt","Current Block Time":1391457585.060405,"Current Block Hash":"0012a85cfa3d1b7cc00bf56a5c8cd283e8ca95995d040c42ff4c66f219e24567","LP":true,"Network Difficulty":10.87349847}],"id":1}
      EOF
    end

    before(:each) do
      expected = '{"command":"asc","parameter":"1"}'
      telnet.stub(:cmd).with(expected).and_return(reply)
      telnet.should_receive(:close)
    end

    specify { expect(subject.asc(1)).to be_a(CGMiner::API::Response) }

  end

  context 'failed communication' do

    before(:each) do
      telnet.stub(:cmd).and_raise(TimeoutError)
      telnet.should_receive(:close)
    end

    specify { expect { subject.asc(0) }.to raise_error(TimeoutError) }

    specify { expect { subject.asccount }.to raise_error(TimeoutError) }

    specify { expect { subject.check(:version) }.to raise_error(TimeoutError) }

    specify { expect { subject.coin }.to raise_error(TimeoutError) }

    specify { expect { subject.config }.to raise_error(TimeoutError) }

    specify { expect { subject.devdetails }.to raise_error(TimeoutError) }

    specify { expect { subject.devs }.to raise_error(TimeoutError) }

    specify { expect { subject.gpu(0) }.to raise_error(TimeoutError) }

    specify { expect { subject.gpucount }.to raise_error(TimeoutError) }

    specify { expect { subject.pga(0) }.to raise_error(TimeoutError) }

    specify { expect { subject.pgacount }.to raise_error(TimeoutError) }

    specify { expect { subject.pools }.to raise_error(TimeoutError) }

    specify { expect { subject.stats }.to raise_error(TimeoutError) }

    specify { expect { subject.summary }.to raise_error(TimeoutError) }

    specify { expect { subject.usbstats }.to raise_error(TimeoutError) }

    specify { expect { subject.version }.to raise_error(TimeoutError) }

  end

  context 'invalid JSON response' do

    let(:reply) { "I AM A PRETTY BAD RESPONSE" }

    before(:each) do
      telnet.stub(:cmd).and_return(reply)
      telnet.should_receive(:close)
    end

    specify { expect { subject.asc(0) }.to raise_error(JSON::ParserError) }

    specify { expect { subject.asccount }.to raise_error(JSON::ParserError) }

    specify { expect { subject.check(:version) }.to raise_error(JSON::ParserError) }

    specify { expect { subject.coin }.to raise_error(JSON::ParserError) }

    specify { expect { subject.config }.to raise_error(JSON::ParserError) }

    specify { expect { subject.devdetails }.to raise_error(JSON::ParserError) }

    specify { expect { subject.devs }.to raise_error(JSON::ParserError) }

    specify { expect { subject.gpu(0) }.to raise_error(JSON::ParserError) }

    specify { expect { subject.gpucount }.to raise_error(JSON::ParserError) }

    specify { expect { subject.pga(0) }.to raise_error(JSON::ParserError) }

    specify { expect { subject.pgacount }.to raise_error(JSON::ParserError) }

    specify { expect { subject.pools }.to raise_error(JSON::ParserError) }

    specify { expect { subject.stats }.to raise_error(JSON::ParserError) }

    specify { expect { subject.summary }.to raise_error(JSON::ParserError) }

    specify { expect { subject.usbstats }.to raise_error(JSON::ParserError) }

    specify { expect { subject.version }.to raise_error(JSON::ParserError) }

  end

  its(:host) { should eql('my-hostname') }

  its(:port) { should eql(1234) }

end