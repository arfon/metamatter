require_relative 'helpers'

module Metamatter
  class Readme
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
    # Returns a DOI URL 10.5281/zenodo.9789 or nil
    def doi
      if has_zenodo_badge?
        match = contents.match(/\d{2}.\d{4}\/zenodo.\d*/)[0]
        return match
      else
        return nil
      end
    end

    def github_response
      @github_response ||= client.readme(repository.name_with_owner)
    end
  end
end
