require 'yaml'
require 'fileutils'
require 'github_api'

class Puller
  attr_accessor :projects, :org, :dir_path

  def initialize(org, dir_path = 'tmp', projects = nil)
    @org = org
    @dir_path = dir_path
    @projects = projects || YAML.load(File.read(File.expand_path('../projects.yml', __FILE__)))
  end

  def fork_projects(basic_auth)
    github_client = Github.new basic_auth: basic_auth
    projects.each do |proj|
      begin
        author, proj_name = proj.split('/')
        github_client.repos.forks.create author, proj_name, organization: org
        puts "#{proj} is forked to #{org}/#{proj_name}"
      rescue
        puts "#{proj} is not forked"
      end
    end
  end

  def renew_projects
    FileUtils.mkdir dir_path
    FileUtils.cd dir_path
    projects.each do |proj|
      begin
        author, proj_name = proj.split('/')
        `git clone https://github.com/#{org}/#{proj_name}.git`
        FileUtils.cd proj_name
        `git remote add original https://github.com/#{proj}.git`
        `git pull original master`
        `git push origin master`
        FileUtils.cd '..'
        puts "#{proj} is updated"
      rescue
        puts "#{proj} is not updated"
      ensure
        FileUtils.rm_rf proj_name
      end
    end
  ensure
    FileUtils.cd '..'
    FileUtils.rm_rf dir_path
  end
end
