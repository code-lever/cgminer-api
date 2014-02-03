require 'spec_helper'

describe CGMiner::API::Client do

  let(:host) { 'my-hostname' }

  let(:port) { 1234 }

  before(:each) do
    @client = described_class.new(host, port)
  end

  subject { @client }

  its(:host) { should eql('my-hostname') }

  its(:port) { should eql(1234) }

end