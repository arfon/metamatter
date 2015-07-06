require 'octokit'

module Metamatter
  class << self
    # Authenticated Octokit
    def client
      @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
    end

    def extract(repo_with_owner)
      # Do something like...
      # Get contributors
      authors = contributors(repo_with_owner)
      # Get the readme
      # To some LDA analysis on the README to work out what this project is doing
    end

    def contributors(repo_with_owner)
      authors = []
      contribs = contributors_response(repo_with_owner)
      contribs.each do |c|
        user = client.user(c.login)
        authors << {:name => user.name, :email => user.email, :login => user.login, :contributions => c.contributions}
      end

      return authors.sort_by { |a| a[:contributions] }.reverse
    end

    def contributors_response(repo_with_owner)
      @response ||= client.contributors(repo_with_owner)
    end
  end
end
