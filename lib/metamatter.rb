require 'octokit'

require_relative 'metamatter/classification'
require_relative 'metamatter/authors'
require_relative 'metamatter/helpers'
require_relative 'metamatter/license'
require_relative 'metamatter/readme'

module Metamatter
  class Repository
    include Helpers

    attr_accessor :owner
    attr_accessor :name

    # Public: Initialize a new Repository from a GitHub repo with owner
    #
    # repo_with_owner - e.g. arfon/metamatter
    #
    # Returns a Repository.
    def initialize(repo_with_owner)
      @owner, @name = repo_with_owner.split('/')
    end

    # Public: Convenience method for returning the owner with name
    #
    # Returns a string e.g. 'arfon/metamatter'
    def name_with_owner
      [owner, name].join('/')
    end

    # Public: Returns the full metadata for the repository
    #
    # Returns metatdata hash.
    def extract
      return JSON.pretty_generate({ :repository => self.to_hash,
                                    :authors => authors,
                                    :tags => tags,
                                    :license => license,
                                    :doi => doi })
    end

    # Public: Returns the full list of contributors to the repository sorted
    #         by their contribution count
    #
    # Returns authors hash.
    def authors
      Metamatter::Authors.new(self).list
    end

    # Public: Returns the tags from the Algorithmia classification
    #
    # Returns list of tags or nil.
    def tags
      Metamatter::Classification.new(self).tags
    end

    # Public: Returns the license detected for the repository
    #
    # Returns license hash or nil
    def license
      Metamatter::License.new(self).license
    end

    # Public: Returns any known DOIs for the repository
    #
    # Returns a DOI string or nil
    def doi
      Metamatter::Readme.new(self).doi
    end

    # Private: The GitHub Repository response
    #
    # Returns a cached Octokit response hash
    def github_response
      @github_response ||= client.repository(name_with_owner)
    end

    # Private: Returns a summary hash for the repository
    #
    # Returns a hash
    def to_hash
      {
        :name => github_response.name,
        :location => github_response.html_url,
        :description => github_response.description,
        :created_at => github_response.created_at
      }
    end
  end
end
