require 'algorithmia'

module Metamatter
  class Classification
    attr_accessor :owner
    attr_accessor :repository

    def initialize(options)
      @owner = options[:owner]
      @repository = options[:repository]
    end

    def tags
      Algorithmia.api_key = ENV['ALGORITHMIA_TOKEN']
      # Expects params as [owner, repo] - see https://algorithmia.com/algorithms/tags/AutoTagGithub
      query = Algorithmia.call("tags/AutoTagGithub", [owner, repository])
      return query.result.keys
    end
  end
end
