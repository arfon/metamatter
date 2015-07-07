module Helpers
  # Authenticated Octokit
  # TODO remove license preview media type when this ships
  MEDIA_TYPE = "application/vnd.github.drax-preview+json"

  def client
    @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'],
                                    :default_media_type => MEDIA_TYPE)
  end
end
