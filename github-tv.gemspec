Gem::Specification.new do |gem|
  gem.name          = 'github-tv'
  gem.version       = '0.4'
  gem.license       = 'MIT'
  gem.authors       = ['brainopia', 'gazay']
  gem.email         = 'brainopia@evilmartians.com'
  gem.summary       = 'Forks your colleagues open-source repos to organization page'
  gem.homepage      = 'https://github.com/evilmartians/github-tv'
  gem.files         = `git ls-files`.split($/)
  gem.require_paths = %w(lib)
  gem.executables   = 'github-tv'

  gem.add_dependency 'octokit'
end

