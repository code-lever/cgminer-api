require 'spec_helper'

describe CGMiner::API::Response do

  before(:each) do
    @response = described_class.new(:coin, raw)
  end

  subject { @response }

  context 'successful response' do

    let(:raw) do
      <<-EOF
{"STATUS":[{"STATUS":"S","When":1391459548,"Code":78,"Msg":"CGMiner coin","Description":"cgminer 3.7.2"}],"COIN":[{"Hash Method":"scrypt","Current Block Time":1391457585.060405,"Current Block Hash":"0012a85cfa3d1b7cc00bf56a5c8cd283e8ca95995d040c42ff4c66f219e24567","LP":true,"Network Difficulty":10.87349847}],"id":1}
      EOF
    end

    its(:success?) { should be_true }

  end

  context 'invalid command response' do

    let(:raw) do
      <<-EOF
{"STATUS":[{"STATUS":"E","When":1391459330,"Code":14,"Msg":"Invalid command","Description":"cgminer 3.7.2"}],"id":1}
      EOF
    end

    its(:success?) { should be_false }

  end

end
