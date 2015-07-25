require_relative 'helpers'

module Metamatter
  class Doi
    include Helpers

    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def contents
      contents = github_response
      return Base64.decode64(contents.content)
    end

    def has_zenodo_badge?
      contents.include?('zenodo.org/badge')
    end

    # Find the Zenodo DOI if it's there
    # Returns a DOI URL http://dx.doi.org/10.5281/zenodo.9789 or nil
    def detect
      if has_zenodo_badge?
        match = contents.match(/(dx.doi.org\/)\d{2}.\d{4}\/zenodo.\d*/)[0]
        return "http://#{match}"
      else
        return nil
      end
    end

    def github_response
      @github_response ||= client.readme(repository.name_with_owner)
    end
  end
end
