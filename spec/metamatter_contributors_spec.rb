require_relative 'spec_helper'

describe Metamatter::Contributors do
  subject(:repository) { Metamatter::Repository.new('arfon/metamatter') }
  subject(:authors) { Metamatter::Contributors.new(repository) }

  it "can list authors" do
    VCR.use_cassette('contributors') do
      expect(authors.list.first[:login]).to eql('arfon')
    end
  end
end
