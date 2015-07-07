require 'octokit'
require_relative 'metamatter/classification'
require_relative 'metamatter/contributors'

module Metamatter
  class Repository
    attr_accessor :owner
    attr_accessor :repository

    def initialize(repo_with_owner)
      @owner, @repository = repo_with_owner.split('/')
    end

    def extract
      authors = Contributors.new(:repository => repository,
                                 :owner => owner).list
      # To some LDA analysis on the README to work out what this project is doing
      tags = Classification.new(:repository => repository,
                                :owner => owner).tags

      return JSON.pretty_generate({:authors => authors, :tags => tags})
    end
  end
end
