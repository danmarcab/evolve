require './lib/evolve/version'

Gem::Specification.new do |s|
  s.name        = 'evolve'
  s.version     = Evolve::VERSION
  s.license     = 'MIT'

  s.summary     = 'Simple genetic algorithm'
  s.description = 'Evolve provides a simple and readable interface to make genetic algorithm optimization easy'
  s.authors     = ['Daniel Marin Cabillas']
  s.email       = 'danmarcab@gmail.com'
  s.homepage    =  'https://github.com/danmarcab/evolve'

  s.add_development_dependency "rspec", "~>3.0"

  s.files         = `git ls-files -- lib/*`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

end
