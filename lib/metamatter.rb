require 'octokit'
require_relative 'metamatter/classification'
require_relative 'metamatter/contributors'
require_relative 'metamatter/helpers'
require_relative 'metamatter/license'
require_relative 'metamatter/readme'

module Metamatter
  class Repository
    include Helpers

    attr_accessor :owner
    attr_accessor :name

    def initialize(repo_with_owner)
      @owner, @name = repo_with_owner.split('/')
    end

    def name_with_owner
      [owner, name].join('/')
    end

    def extract
      authors = Contributors.new(self).list

      # To some LDA analysis on the README to work out what this project is doing
      tags = Classification.new(self).tags

      # License detection
      license = License.new(self).license_hash

      # README parsing for DOI
      doi = Readme.new(self).zenodo_doi

      return JSON.pretty_generate({ :repository => self.to_hash,
                                    :authors => authors,
                                    :tags => tags,
                                    :license => license,
                                    :doi => doi })
    end

    def github_response
      @github_response ||= client.repository(name_with_owner)
    end

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
