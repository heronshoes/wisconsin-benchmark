require 'wisconsin-benchmark'
require 'test_helper'

class WisconsinBenchmarkTest < Test::Unit::TestCase
  test 'VERSION' do
    assert do
      ::WisconsinBenchmark.const_defined?(:VERSION)
    end
  end

  test 'out of range in array' do
    assert_raise(RuntimeError) { WisconsinBenchmark::Array.new(100_000_001) }
  end

  sub_test_case 'numeric array' do
    data(
      '1E1' => [10, [9, 1, 2, 3, 5, 7, 8, 4, 6, 0]],
      '1E2' => [100, [69, 9, 86, 56, 65, 51, 31, 35, 99, 58]],
      '1E3' => [1000, [147, 931, 714, 711, 883, 439, 670, 543, 425, 800]],
      '1E4' => [10000, [8800, 1891, 3420, 9850, 7164, 8009, 5057, 6701, 4321, 3043]],
      '1E5' => [100000, [32293, 9402, 71151, 51373, 13756, 22185, 55231, 53191, 8699, 30916]],
      '1E6' => [1000000,
                [439436, 890983, 297656, 161417, 106705, 828869, 423851, 53484, 692558, 217435]],
      '1E7' => [10000000,
                [44520, 9393930, 2115678, 6407432, 1965797, 4782598, 9126488, 5685530, 9644779,
                 5044722]],
      # '1E8' => [100000000,
      #           [440, 9260, 194480, 4084100, 85766120, 1088414, 22856714, 79990986, 79810614,
      #            76022802]],
    )

    def test_numeric_array(data)
      size, values10 = data
      array = WisconsinBenchmark::Array.new(size)

      assert_instance_of Numo::UInt32, array.unique1
      assert_equal values10, array.unique1[0..9].to_a
      assert_equal 0, array.unique1.min
      assert_equal size - 1, array.unique1.max

      assert_instance_of Numo::UInt32, array.unique2
      assert_equal array.unique2.to_a, array.unique1.sort.to_a
    end
  end

  sub_test_case 'string array' do
    data(
      '1E1' => [10, %w[
        AAAAAAJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAABxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAADxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E2' => [100, %w[
        AAAAACRxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAAJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAADIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAACExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAACNxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAABZxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAABFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAABJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAADVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAACGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E3' => [1_000, %w[
        AAAAAFRxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAABJVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAABBMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAABBJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAABHZxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAQXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAZUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAUXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAAQJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAABEUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E4' => [10_000, %w[
        AAAANAMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAACUTxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAFBOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAOOWxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAKPOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAALWBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAHMNxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAJXTxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAGKFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAENBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E5' => [100_000, %w[
        AAABVUBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAANXQxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAEBGPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAACXZXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAUJCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAABGVHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAADDSHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAADARVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAAMWPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAABTTCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E6' => [1_000_000, %w[
        AAAZABKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AABYSAPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAQYIIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAJEUJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAGBWBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AABVEDPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAYCZZxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAADBDCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AABNKMWxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAAMJQXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      '1E7' => [10_000_000, %w[
        AAACNWIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAUOMJAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAEQJSGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAOAOLSxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAEHVZPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAKMCWCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AATZGSUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAMLMOGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AAVCTLBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        AALBAPUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]],
      # '1E8' => [100_000_000, %w[
      #   AAAAAQYxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AAAANSExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AAALBSAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AAIYJOUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AHFRSYYxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AACJYCCxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   ABYALSKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AGTBDWKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AGSQXBAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      #   AGKJJTYxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      # ]],
    )

    def test_string_array(data)
      size, values10 = data
      array = WisconsinBenchmark::Array.new(size)
      min = 'AAAAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

      assert_instance_of Array, array.stringu1
      assert_equal values10, array.stringu1[0..9].to_a
      assert_equal min, array.stringu1.min

      assert_instance_of Array, array.stringu2
      assert_equal array.stringu2.to_a, array.stringu1.sort.to_a

      expect = %w[
        AAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        HHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        OOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        VVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      ]
      expect = (expect * 3)[0..9]
      assert_instance_of Array, array.string4
      assert_equal expect, array.string4[0..9].to_a
    end
  end

  sub_test_case 'table' do
    test 'generate table' do
      table = WisconsinBenchmark::Table.new(20).generate

      expect = <<~STR
        \tunique1\tunique2\ttwo\tfour\tten\ttwenty\tonePercent\ttenPercent\ttwentyPercent\tfiftyPercent\tunique3\tevenOnePercent\toddOnePercent\tstringu1\tstringu2\tstring4
         0\t      9\t      0\t  1\t   1\t  9\t     9\t         9\t         9\t            4\t           1\t      9\t            18\t           19\tAAAAAAJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         1\t     14\t      1\t  0\t   2\t  4\t    14\t        14\t         4\t            4\t           0\t     14\t            28\t           29\tAAAAAAOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAABxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tHHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         2\t     13\t      2\t  1\t   1\t  3\t    13\t        13\t         3\t            3\t           1\t     13\t            26\t           27\tAAAAAANxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tOOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         3\t      1\t      3\t  1\t   1\t  1\t     1\t         1\t         1\t            1\t           1\t      1\t             2\t            3\tAAAAAABxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAADxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tVVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         4\t     19\t      4\t  1\t   3\t  9\t    19\t        19\t         9\t            4\t           1\t     19\t            38\t           39\tAAAAAATxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         5\t      2\t      5\t  0\t   2\t  2\t     2\t         2\t         2\t            2\t           0\t      2\t             4\t            5\tAAAAAACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tHHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         6\t      3\t      6\t  1\t   3\t  3\t     3\t         3\t         3\t            3\t           1\t      3\t             6\t            7\tAAAAAADxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tOOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         7\t     10\t      7\t  0\t   2\t  0\t    10\t        10\t         0\t            0\t           0\t     10\t            20\t           21\tAAAAAAKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tVVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         8\t      5\t      8\t  1\t   1\t  5\t     5\t         5\t         5\t            0\t           1\t      5\t            10\t           11\tAAAAAAFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
         9\t     12\t      9\t  0\t   0\t  2\t    12\t        12\t         2\t            2\t           0\t     12\t            24\t           25\tAAAAAAMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAJxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tHHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        10\t      7\t     10\t  1\t   3\t  7\t     7\t         7\t         7\t            2\t           1\t      7\t            14\t           15\tAAAAAAHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tOOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        11\t      8\t     11\t  0\t   0\t  8\t     8\t         8\t         8\t            3\t           0\t      8\t            16\t           17\tAAAAAAIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAALxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tVVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        12\t     18\t     12\t  0\t   2\t  8\t    18\t        18\t         8\t            3\t           0\t     18\t            36\t           37\tAAAAAASxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        13\t     11\t     13\t  1\t   3\t  1\t    11\t        11\t         1\t            1\t           1\t     11\t            22\t           23\tAAAAAALxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAANxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tHHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        14\t      4\t     14\t  0\t   0\t  4\t     4\t         4\t         4\t            4\t           0\t      4\t             8\t            9\tAAAAAAExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tOOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        15\t     15\t     15\t  1\t   3\t  5\t    15\t        15\t         5\t            0\t           1\t     15\t            30\t           31\tAAAAAAPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAPxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tVVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        16\t     17\t     16\t  1\t   1\t  7\t    17\t        17\t         7\t            2\t           1\t     17\t            34\t           35\tAAAAAARxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAAQxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        17\t     16\t     17\t  0\t   0\t  6\t    16\t        16\t         6\t            1\t           0\t     16\t            32\t           33\tAAAAAAQxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAARxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tHHHHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        18\t      6\t     18\t  0\t   2\t  6\t     6\t         6\t         6\t            1\t           0\t      6\t            12\t           13\tAAAAAAGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAASxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tOOOOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        19\t      0\t     19\t  0\t   0\t  0\t     0\t         0\t         0\t            0\t           0\t      0\t             0\t            1\tAAAAAAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tAAAAAATxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\tVVVVxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      STR
      assert_equal expect, table.to_s
    end
  end
end
