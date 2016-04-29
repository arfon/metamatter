require_relative 'helpers'
require 'httparty'
require 'json'

module Metamatter
  class Authors
    include Helpers

    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def list
      authors = []
      contribs = github_response
      contribs.each do |c|
        user = client.user(c.login)
        orcid = lookup_orcid(user.name)

        authors << {:name => user.name, :orcid => orcid, :email => user.email, :login => user.login, :contributions => c.contributions}
      end

      return authors.sort_by { |a| a[:contributions] }.reverse
    end

    def lookup_orcid(name)
      return "" unless name
      family_name = name.split(' ').last
      given_names = name.gsub(family_name, '').strip # hackety hack hack
      url = orcid_search_url(given_names, family_name)

      begin
        response = HTTParty.get(url, :headers => { "Accept" =>  "application/json"}).body
      rescue => e
        response = {}
      end

      orcids = orcids_for(response)

      if orcids.empty?
        return nil
      else
        return orcids.first
      end
    end

    def orcid_search_url(given_names, family_name)
      "https://orcid.org/v1.2/search/orcid-bio/?q=given-names%3A#{given_names}%20AND%20family-name%3A#{family_name}&rows=50"
    end

    def orcids_for(response)
      parsed = JSON.parse(response)
      return nil unless parsed["orcid-search-results"]
      results = parsed["orcid-search-results"]["orcid-search-result"]
      return nil if results.empty?

      detected_orcids = Array(results).map do |result|
        orcid = result['orcid-profile']['orcid-identifier'].fetch("path", nil)
      end.compact

      log_orcids(detected_orcids) if detected_orcids.size > 1
      return detected_orcids
    end

    def log_orcids(orcids)
      puts "Warning: More than one ORCID from search returned"
      orcids.each { |orcid| puts orcid }
    end

    def github_response
      @contributors_response ||= client.contributors(repository.name_with_owner)
    end
  end
end
