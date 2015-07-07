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

    def github_response
      @github_response ||= client.readme(repository.name_with_owner)
    end
  end
end
