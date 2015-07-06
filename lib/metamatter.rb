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
      # Get the readme
      # To some LDA analysis on the README to work out what this project is doing
    end
  end
end
