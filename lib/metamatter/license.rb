require_relative 'helpers'

module Metamatter
  class License
    include Helpers

    attr_accessor :repository

    def initialize(repository)
      @repository = repository
    end

    def has_license?
      !github_response.license.nil?
    end

    def license
      if has_license?
        {
          :name => github_response.license.name,
          :url => github_response.license.url
        }
      else
        return nil
      end
    end

    def github_response
      @github_response ||= client.repository(repository.name_with_owner)
    end
  end
end
