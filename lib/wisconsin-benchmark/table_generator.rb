module WisconsinBenchmark
  # Arrow::Table generator
  class TableGenerator
    # Create Scaled Wisconsin Benchmark dataset object.
    #
    # @return size [Integer] number of tuples.
    #
    def initialize(size)
      @size = size
      @array = WisconsinBenchmark::ArrayGenerator.new(size)
    end

    attr_reader :table, :size, :array

    # Generate Scaled Wisconsin Benchmark dataset in Arrow::Table.
    #
    # @return [Arrow::Table] generated dataset in Arrow::Table.
    #
    def generate
      unique1 = @array.unique1
      onePercent = unique1 % 100

      @table = Arrow::Table.new(
        [
          [:unique1,        unique1],
          [:unique2,        @array.unique2],
          [:two,            unique1 % 2],
          [:four,           unique1 % 4],
          [:ten,            unique1 % 10],
          [:twenty,         unique1 % 20],
          [:onePercent,     onePercent],
          [:tenPercent,     unique1 % 10],
          [:twentyPercent,  unique1 % 5],
          [:fiftyPercent,   unique1 % 2],
          [:unique3,        unique1],
          [:evenOnePercent, onePercent * 2],
          [:oddOnePercent,  (onePercent * 2) + 1],
          [:stringu1,       @array.stringu1],
          [:stringu2,       @array.stringu2],
          [:string4,        @array.string4]
        ]
      )
    end

    def inspect
      "<#{self.class} (size=#{@size}, table=#{@table ? '#<Arrow::Table>' : 'nil'})>"
    end
  end
end
