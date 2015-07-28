require 'httparty'
require 'json'

module Metamatter
  class Datacite
    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def doi
      docs = datacite_response["response"]["docs"]
      return nil if docs.empty?
      puts "Warning, more than one DOI from Datacite" if docs.size > 1
      Array(docs).map do |doc|
        doi = doc.fetch("doi", nil)
      end.compact
    end

    def datacite_response
      begin
        response = HTTParty.get(url).body
        return JSON.parse(response)
      rescue => e
        return {}
      end
    end

    def url
      "http://search.datacite.org/api?q=relatedIdentifier:https://github.com/#{repository.name_with_owner}&fl=doi,creator,title,publisher,publicationYear,resourceTypeGeneral,datacentre,datacentre_symbol,prefix,relatedIdentifier&fq=is_active:true&fq=has_metadata:true&rows=1000&wt=json"
    end
  end
end
