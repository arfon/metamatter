require_relative 'helpers'

module Metamatter
  class Contributors
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
        authors << {:name => user.name, :email => user.email, :login => user.login, :contributions => c.contributions}
      end

      return authors.sort_by { |a| a[:contributions] }.reverse
    end

    def github_response
      @contributors_response ||= client.contributors(repository.name_with_owner)
    end
  end
end
