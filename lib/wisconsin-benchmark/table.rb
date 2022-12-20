# frozen_string_literal: true

module WisconsinBenchmark
  # Arrow::Table generator
  class Table
    def initialize(size)
      @size = size

      array = WisconsinBenchmark::Array.new(size)

      warn 'Generating unique1'
      @unique1 = array.unique1

      warn 'Generating unique2'
      @unique2 = array.unique2
    end

    attr_reader :table

    def generate
      @table = Arrow::Table.new(
        [
          [:unique1,        @unique1],
          [:unique2,        @unique2],
          [:two,            @unique1 % 2],
          [:four,           @unique1 % 4],
          [:ten,            @unique1 % 10],
          [:twenty,         @unique1 % 20],
          [:onePercent,     onePercent = @unique1 % 100],
          [:tenPercent,     @unique1 % 10],
          [:twentyPercent,  @unique1 % 5],
          [:fiftyPercent,   @unique1 % 2],
          [:unique3,        @unique1],
          [:evenOnePercent, onePercent * 2],
          [:oddOnePercent,  (onePercent * 2) + 1],
          [:stringu1,       stringu1],
          [:stringu2,       stringu2],
          [:string4,        string4]
        ]
      )
    end

    private

    def stringu1
      warn 'Generating stringu1'

      trailer = 'x' * 45
      @unique1.to_a.map do |i|
        str = i.to_s(26).tr('0-9a-p', 'A-Z')
        ('A' * (7 - str.size)) << str << trailer
      end
    end

    def stringu2
      warn 'Generating stringu2'

      trailer = 'x' * 45
      (('A' * 7)..).take(@size).map { _1 << trailer }
    end

    def string4
      warn 'Generating string4'

      trailer = 'x' * 48
      array = %w[AAAA HHHH OOOO VVVV].map { _1 << trailer }
      @size.times.map { |i| array[i % 4] }
    end
  end
end
