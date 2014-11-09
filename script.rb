require 'github_api'
require File.expand_path('../puller.rb', __FILE__)

puts 'Enter your github login:'
login = gets.chomp
puts 'Enter your github password:'
password = gets.chomp
puts 'Name of organization:'
organization = gets.chomp

github = Github.new basic_auth: [login, password].join(':')

puller = Puller.new(github, organization, 'tmp')

puts 'what to do? (0 - fork, 1 - renew):'
command = gets.chomp.to_i

puller.fork_projects if command == 0
puller.renew_projects if command == 1
