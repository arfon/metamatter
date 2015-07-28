require_relative 'spec_helper'

describe Metamatter::Datacite do
  subject(:repository) { Metamatter::Repository.new('articlemetrics/lagotto') }
  subject(:datacite_search) { Metamatter::Datacite.new(repository) }

  it "knows the correct Datacite search URL" do
    search_url = "http://search.datacite.org/api?q=relatedIdentifier:https://github.com/articlemetrics/lagotto&fl=doi,creator,title,publisher,publicationYear,resourceTypeGeneral,datacentre,datacentre_symbol,prefix,relatedIdentifier&fq=is_active:true&fq=has_metadata:true&rows=1000&wt=json"
    expect(datacite_search.url).to eql(search_url)
  end

  it "can query the Datacite API" do
    VCR.use_cassette('datacite') do
      expect(datacite_search.datacite_response).to_not be_nil
      expect(datacite_search.datacite_response.to_s).to match(/10.5281\/ZENODO.20039/)
    end
  end

  it "can return a Datacite DOI" do
    VCR.use_cassette('datacite') do
      expect(datacite_search.doi).to eql(["10.5281/ZENODO.20039"])
    end
  end
end
