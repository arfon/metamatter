require 'octokit'
require_relative 'metamatter/classification'
require_relative 'metamatter/contributors'
require_relative 'metamatter/license'
require_relative 'metamatter/readme'

module Metamatter
  class Repository
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

      return JSON.pretty_generate({ :authors => authors,
                                    :tags => tags,
                                    :license => license,
                                    :doi => doi })
    end
  end
end
