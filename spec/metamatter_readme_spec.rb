require_relative 'spec_helper'

describe Metamatter::Readme do
  subject(:repository) { Metamatter::Repository.new('arfon/metamatter') }
  subject(:readme) { Metamatter::Readme.new(repository) }

  it "can return the README contents" do
    VCR.use_cassette('readme') do
      expect(readme.contents.size).to eql(2158)
      expect(readme.contents).to match(/Minimal metadata extractor/)
    end
  end

  it "knows if there is a Zenodo badge present" do
    VCR.use_cassette('readme') do
      expect(readme.has_zenodo_badge?).to be true
    end
  end

  it "knows what the DOI is" do
    VCR.use_cassette('readme') do
      expect(readme.doi).to eql("10.5281/zenodo.19630")
    end
  end
end
