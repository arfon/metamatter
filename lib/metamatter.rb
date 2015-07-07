require 'octokit'
require_relative 'metamatter/classification'
require_relative 'metamatter/contributors'

module Metamatter
  class << self
    def extract(repo_with_owner)
      owner, repo = repo_with_owner.split('/')

      authors = Contributors.new(:repository => repo, :owner => owner).list
      # To some LDA analysis on the README to work out what this project is doing
      tags = Classification.new(:repository => repo, :owner => owner).tags

      return JSON.pretty_generate({:authors => authors, :tags => tags})
    end
  end
end
