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
      expect(subject.doi).to eql("http://dx.doi.org/10.5281/zenodo.19630")
    end
  end
end
