require_relative 'helpers'

module Metamatter
  class Readme
    include Helpers

    attr_accessor :owner
    attr_accessor :repository

    def initialize(options)
      @owner = options[:owner]
      @repository = options[:repository]
    end

    def contents
      contents = github_response
      return Base64.decode64(contents.content)
    end

    def github_response
      @readme_response ||= client.readme("#{owner}/#{repository}")
    end
  end
end
