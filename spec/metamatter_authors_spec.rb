require_relative 'spec_helper'

describe Metamatter::Authors do
  subject(:repository) { Metamatter::Repository.new('arfon/metamatter') }
  subject(:authors) { Metamatter::Authors.new(repository) }

  it "can list authors" do
    VCR.use_cassette('authors') do
      expect(authors.list.first[:login]).to eql('arfon')
    end
  end
end
