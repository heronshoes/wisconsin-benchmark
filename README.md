# Wisconsin Benchmark

[Wisconsin Benchmark](http://jimgray.azurewebsites.net/benchmarkhandbook/chapter4.pdf) is a benchmark for relational database systems and machines developed at University of Wisconsin. It was used to asses early relational data system performance, but it will be useful for the capability of DataFrame and its scalability because it is well designed synthetic dataset.

### Table: Attribute Specification of "Scalable" Wisconsin Benchmark

|Attribute Name| Range of Values | Order | Comment |
|--------------|-----------------|-------|---------|
|unique1       |0-(MAXTUPLES-1)  |random | unique, random order|
|unique2       |0-(MAXTUPLES-1)  |sequential | unique, sequential|
|two           |0-1 |random |(unique1 mod 2)|
|four          |0-3 |random |(unique1 mod 4)|
|ten           |0-9 |random |(unique1 mod 10)|
|twenty        |0-19 |random |(unique1 mod 20)|
|onePercent    |0-99 |random |(unique1 mod 100)|
|tenPercent    |0-9 |random |(unique1 mod 10)|
|twentyPercent |0-4 |random |(unique1 mod 5)|
|fiftyPercent  |0-1 |random |(unique1 mod 2)|
|unique3       |0-(MAXTUPLES-1)| random|unique1|
|evenOnePercent |0,2,4,...,198| random |(onePercent * 2)|
|oddOnePercent |1,3,5,...,199| random |(onePercent * 2)+1|
|stringu1      | - |random |_unique, random order, 52bytes each_|
|stringu2      | - |_sequential_|_unique, sequential, 52bytes each_|
|string4       | - |cyclic|4 _unique string, 52bytes each_|

(This table is taken from Table 2 in [Wisconsin Benchmark](http://jimgray.azurewebsites.net/benchmarkhandbook/chapter4.pdf) and _italic_ letters are added to describe in detail.)

### Benchmark dataset

This project will offer the 'Scaled Wisconsin Benchmark Dataset' in arrow, parquet and csv for 1,000 to 100,000,000 rows.

### Benchmark suites for DataFrames

Coming soon.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add wisconsin-benchmark

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install wisconsin-benchmark

## Usage

To experiment with that code, run `bin/console` for an interactive prompt.

```ruby
require 'wisconsin-benchmark' # if it is not in `bin/console`

table = WisconsinBenchmark::Table.new(1000).generate

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wisconsin-benchmark. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/wisconsin-benchmark/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wisconsin::Benchmark project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wisconsin-benchmark/blob/main/CODE_OF_CONDUCT.md).
