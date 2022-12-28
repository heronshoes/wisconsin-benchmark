module WisconsinBenchmark
  # Array generator
  class ArrayGenerator
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
    #
    # @return [Numo::UInt32] array of attribute :unique1.
    #
    def unique1
      @unique1 ||= begin
        warn 'Generating unique1'

        seed = @generator
        ary = @size.times.map do
          seed = rand(seed)
          seed - 1
        end
        Numo::UInt32.new(@size).store(ary)
      end
    end

    # Create a sequential record array as 0...size.
    #
    # @return [Numo::UInt32] array of attribute :unique2.
    #
    def unique2
      @unique2 ||= begin
        warn 'Generating unique2'

        Numo::UInt32.new(@size).seq
      end
    end

    # Create a randomly distributed string array, stringu1.
    #
    # @return [Array<String>]
    #   array of generated randomly distributed distinct strings.
    #   - Each string is 52 bytes.
    #   - string[0..6] is converted string from numbers in randomly distributed unique1.
    #     The numbers are converted to n-adic string mapped for 'A-Z'.
    #     {1 => 'AAAAAAA', 2 => 'AAAAAAB', ... 26 => 'AAAAAAZ', 27 => 'AAAAABA', ...}
    #   - string[7..] is 'x' * 45
    # @example
    #  ['AAAAAFRxxxxx ... ', 'AAAABJVxxxxx ... ', 'AAAABBMxxxxx ... ', ... ]
    #
    def stringu1
      @stringu1 ||= begin
        warn 'Generating stringu1'

        trailer = 'x' * 45
        unique1.to_a.map do |i|
          str = i.to_s(26).tr('0-9a-p', 'A-Z')
          ('A' * (7 - str.size)) << str << trailer
        end
      end
    end

    # Create a sequencial string array, stringu2.
    #
    # @return [Array<String>]
    #   sequential array of strings.
    #   - Each string is 52 bytes.
    #   - string[0..6] is sequential string consists of 'A'..'Z' started from 'AAAAAAA'.
    #   - string[7..] is 'x' * 45
    # @example
    #  ['AAAAAAAxxxxx ... ', 'AAAAAABxxxxx ... ', 'AAAAAACxxxxx ... ', ... ]
    #
    def stringu2
      @stringu2 ||= begin
        warn 'Generating stringu2'

        trailer = 'x' * 45
        (('A' * 7)..).take(@size).map { _1 << trailer }
      end
    end

    # Create a cyclic repeated string array, string4.
    #
    # @return [Array<String>]
    #   cyclic repeating array of strings.
    #   - Each string is 52 bytes.
    #   - string[0..3] is one of ['AAAA', 'HHHH', 'OOOO', 'VVVV'].
    #   - string[7..] is 'x' * 48
    #   - four strings are repeated.
    # @example
    #  ['AAAAxxxxx ... ', 'HHHHxxxxx ... ', 'OOOOxxxxx ... ', 'VVVVxxxxx ...', ... ]
    #
    def string4
      @string4 ||= begin
        warn 'Generating string4'

        trailer = 'x' * 48
        array = %w[AAAA HHHH OOOO VVVV].map { _1 << trailer }
        @size.times.map { |i| array[i % 4] }
      end
    end

    private

    # Get pseudo-random integers by a linear congruential generator.
    def rand(seed)
      loop do
        seed = (@generator * seed) % @prime
        break if seed <= @size
      end
      seed
    end
  end
end
