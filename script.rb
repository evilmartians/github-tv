require File.expand_path('../puller.rb', __FILE__)

puts 'Name of organization:'
organization = gets.chomp

puller = Puller.new(organization, 'tmp')

puts 'what to do? (0 - fork, 1 - renew):'
command = gets.chomp.to_i

if command == 0
  puts 'Enter your github login:'
  login = gets.chomp
  puts 'Enter your github password:'
  password = gets.chomp

  basic_auth = [login, password].join(':')
  puller.fork_projects(basic_auth)
else
  puller.renew_projects
end
