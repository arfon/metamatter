require_relative 'spec_helper'

describe Metamatter do

  subject { Metamatter::Repository.new('arfon/metamatter') }

  it "knows how to return #name_with_owner" do
    expect(subject.name_with_owner).to eql('arfon/metamatter')
  end

  it "can return #authors" do
    VCR.use_cassette('authors') do
      expect(subject.authors.first[:login]).to eql('arfon')
    end
  end

  it "can return a #tags" do
    VCR.use_cassette('algorithmia') do
      expect(subject.tags).to eql(["output", "blog", "context", "usage", "entities", "post", "similar", "semantic"])
    end
  end

  it "can return #license" do
    VCR.use_cassette('license') do
      expect(subject.license[:name]).to eql('MIT License')
    end
  end

  it "can return #doi" do
    VCR.use_cassette('readme') do
      expect(subject.doi).to eql("10.5281/zenodo.19630")
    end
  end

  # Zenodo DOI (from badge) is 10.5281/zenodo.20046
  # Datacite DOI is 10.5281/ZENODO.20039
  it "can return the Datacite DOI when there are both Zenodo and Datacite entries" do
    repository = Metamatter::Repository.new('articlemetrics/lagotto')
    VCR.use_cassette('datacite') do
      VCR.use_cassette('lagotto_readme') do
        expect(repository.doi).to eql("10.5281/zenodo.20046")
      end
    end
  end
end
