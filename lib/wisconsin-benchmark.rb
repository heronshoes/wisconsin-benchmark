# frozen_string_literal: true

require 'arrow-numo-narray'
require 'parquet'

require_relative 'wisconsin-benchmark/array_generator'
require_relative 'wisconsin-benchmark/table_generator'
require_relative 'wisconsin-benchmark/version'

module WisconsinBenchmark
  class Error < StandardError; end
end
