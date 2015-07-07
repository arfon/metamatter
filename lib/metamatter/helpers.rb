module Helpers
  # Authenticated Octokit
  def client
    @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
  end
end
