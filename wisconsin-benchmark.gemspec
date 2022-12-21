# frozen_string_literal: true

require_relative 'lib/wisconsin-benchmark/version'

Gem::Specification.new do |spec|
  spec.name = 'wisconsin-benchmark'
  spec.version = WisconsinBenchmark::VERSION
  spec.authors = ['Hirokazu SUZUKI (heronshoes)']
  spec.email = ['heronshoes877@gmail.com']

  spec.summary = 'Wisconsin Benchmark dataset generator.'
  spec.description = 'Scalable Wisconsin Benchmark dataset generator for Arrow/Parquet.'
  spec.homepage = 'https://github.com/heronshoes/wisconsin-benchmark'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://github.com/heronshoes/wisconsin-benchmark.git'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/heronshoes/wisconsin-benchmark'
  spec.metadata['changelog_uri'] = 'https://github.com/heronshoes/wisconsin-benchmark/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'red-arrow', '~> 10.0.0'
  spec.add_dependency 'red-arrow-numo-narray'

  # Development dependency has gone to the Gemfile (rubygems/bundler#7237)

  spec.metadata['rubygems_mfa_required'] = 'true'
end
