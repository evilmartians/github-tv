require 'yaml'
require 'octokit'

class GithubTV
  attr_reader :token, :org, :repos

  def initialize(config)
    @token = config.fetch 'token'
    @repos = config.fetch 'repos'
    @org   = config.fetch 'organization'
  end

  def run
    repos.each do |repo|
      Sync.new(client, org, repo).run
    end
  end

  private

  def client
    @client ||= Octokit::Client
      .new(access_token: token)
      .tap(&:user) # check auth

  rescue Octokit::Unauthorized
    raise "Your token (#{token.inspect}) is invalid"
  end

  class Sync
    def initialize(client, target, source_repo)
      @client = client
      @target = target
      @source, @project = source_repo.split('/')
    end

    def run
      if @client.repository? target_repo
        fast_forward
        puts "#@project fast-forwarded"
      else
        @client.fork source_repo, organization: @target
        puts "#@project forked"
      end
    end

    private

    def fast_forward
      system <<-SH
        [ -d #@project.git ] || git clone --mirror #{source_url}
        cd #@project.git
        git fetch -p origin
        git push --mirror #{target_url}
      SH
    end

    def target_repo
      "#@target/#@project"
    end

    def source_repo
      "#@source/#@project"
    end

    def source_url
      "https://github.com/#{source_repo}.git"
    end

    def target_url
      "https://#{@client.access_token}@github.com/#{target_repo}.git"
    end
  end
end
