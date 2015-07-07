require 'algorithmia'

module Metamatter
  class Classification
    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def tags
      Algorithmia.api_key = ENV['ALGORITHMIA_TOKEN']
      # Expects params as [owner, repo] - see https://algorithmia.com/algorithms/tags/AutoTagGithub
      query = Algorithmia.call("tags/AutoTagGithub", [repository.owner, repository.name])
      return query.result.keys
    end
  end
end
