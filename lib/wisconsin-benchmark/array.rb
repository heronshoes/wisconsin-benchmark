# frozen_string_literal: true

module WisconsinBenchmark
  # Array generator
  class Array
    def initialize(size)
      if    size <= 1000      then @generator = 279;   @prime = 1009
      elsif size <= 10000     then @generator = 2969;  @prime = 10007
      elsif size <= 100000    then @generator = 21395; @prime = 100003
      elsif size <= 1000000   then @generator = 2107;  @prime = 1000003
      elsif size <= 10000000  then @generator = 211;   @prime = 10000019
      elsif size <= 100000000 then @generator = 21;    @prime = 100000007
      else
        raise "too many rows requested #{size}"
      end
      @size = size
    end

    # Create a random/unique record array
    #   0...size in range
    def unique1
      seed = @generator
      a = @size.times.map do
        seed = rand(seed)
        seed - 1
      end
      Numo::UInt32.new(@size).store(a)
    end

    # Create a sequential record array
    #   as 0...size
    def unique2
      Numo::UInt32.new(@size).seq.to_arrow_array
    end

    private

    def rand(seed)
      loop do
        seed = (@generator * seed) % @prime
        break if seed <= @size
      end
      seed
    end
  end
end
