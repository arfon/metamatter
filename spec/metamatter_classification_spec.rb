require_relative 'spec_helper'

describe Metamatter::Classification do
  subject(:repository) { Metamatter::Repository.new('arfon/metamatter') }
  subject(:classification) { Metamatter::Classification.new(repository) }

  it "can retrieve the Algorithmia tags" do
    VCR.use_cassette('algorithmia') do
      expect(classification.tags).to eql(["output", "blog", "context", "usage", "entities", "post", "similar", "semantic"])
    end
  end
end
