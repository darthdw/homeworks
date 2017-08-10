# RESULTS: 
#
# Press any key to benchmark sorts for 5 elements
#                 user     system      total        real
# Tot. Merge:    0.000000   0.000000   0.000000 (  0.000109)
# Tot. Bubble:   0.000000   0.000000   0.000000 (  0.000044)
# Avg. Merge:    0.000000   0.000000   0.000000 (  0.000036)
# Avg. Bubble:   0.000000   0.000000   0.000000 (  0.000015)
# Press any key to benchmark sorts for 50 elements
#                 user     system      total        real
# Tot. Merge:    0.000000   0.000000   0.000000 (  0.001136)
# Tot. Bubble:   0.000000   0.000000   0.000000 (  0.001287)
# Avg. Merge:    0.000000   0.000000   0.000000 (  0.000379)
# Avg. Bubble:   0.000000   0.000000   0.000000 (  0.000429)
# Press any key to benchmark sorts for 500 elements
#                 user     system      total        real
# Tot. Merge:    0.010000   0.000000   0.010000 (  0.008492)
# Tot. Bubble:   0.080000   0.000000   0.080000 (  0.081697)
# Avg. Merge:    0.003333   0.000000   0.003333 (  0.002831)
# Avg. Bubble:   0.026667   0.000000   0.026667 (  0.027232)
# Press any key to benchmark sorts for 5000 elements
#                 user     system      total        real
# Tot. Merge:    0.060000   0.000000   0.060000 (  0.061949)
# Tot. Bubble:   8.090000   0.020000   8.110000 (  8.210667)
# Avg. Merge:    0.020000   0.000000   0.020000 (  0.020650)
# Avg. Bubble:   2.696667   0.006667   2.703333 (  2.736889)
# Press any key to benchmark sorts for 50000 elements
#                 user     system      total        real
# Tot. Merge:    0.710000   0.000000   0.710000 (  0.720577)
# Tot. Bubble: ^Csorting.rb:14:in `block in bubble_sort!': Interrupt
# 	from sorting.rb:13:in `each'
# 	from sorting.rb:13:in `bubble_sort!'
# 	from sorting.rb:25:in `bubble_sort'
# 	from sorting.rb:76:in `block in run_bubble_sort'
# 	from sorting.rb:74:in `each'
# 	from sorting.rb:74:in `run_bubble_sort'
# 	from sorting.rb:64:in `block (2 levels) in performance_test'
# 	from /usr/lib/ruby/2.3.0/benchmark.rb:293:in `measure'
# 	from /usr/lib/ruby/2.3.0/benchmark.rb:375:in `item'
# 	from sorting.rb:64:in `block in performance_test'
# 	from /usr/lib/ruby/2.3.0/benchmark.rb:173:in `benchmark'
# 	from sorting.rb:61:in `performance_test'
# 	from sorting.rb:93:in `block in run_performance_tests'
# 	from sorting.rb:88:in `each'
# 	from sorting.rb:88:in `run_performance_tests'
# 	from sorting.rb:103:in `<main>'
#
# NB: I was mostly just screwing around here, and I let the bubble sort
# run for a while, thinking it wasn't a big deal really. I got up, grabbed
# a soda, and came back, thinking that going from 9 seconds to 900 seconds
# was pretty basic. And then I realized it wasn't 900 seconds. It was 9000
# seconds. Or a bit under two hours. Sorry for the Ctrl+C there, but I'm not
# leaving a bubble sort running that long just for accurate numbers.




#!/usr/bin/env ruby
require 'io/console'
require 'benchmark'

class SortingDemo
  # Bubble Sort: O(n^2)
  def self.bubble_sort!(array)
    len = array.length - 1
    sorted = false

    until sorted
      sorted = true
      (0...len).each do |idx|
        if array[idx] > array[idx + 1]
          array[idx], array[idx + 1] = array[idx + 1], array[idx]
          sorted = false
        end
      end
    end

    array
  end

  def self.bubble_sort(array)
    bubble_sort!(array.dup)
  end

  # Merge Sort: O(n*lg(n))
  def self.merge_sort (array, &prc)
    return array if array.length <= 1

    mid_idx = array.length / 2
    merge(
      merge_sort(array.take(mid_idx), &prc),
      merge_sort(array.drop(mid_idx), &prc),
      &prc
    )
  end

  # NB: In Ruby, shift is an O(1) operation. This is not true of all languages.
  def self.merge(left, right, &prc)
    merged_array = []
    prc = Proc.new { |num1, num2| num1 <=> num2 } unless block_given?
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged_array << left.shift
      when 0
        merged_array << left.shift
      when 1
        merged_array << right.shift
      end
    end

    merged_array + left + right
  end

  def self.performance_test(size, count)
    arrays_to_test = Array.new(count) { random_arr(size) }

    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. Merge:  ", "Avg. Bubble: ") do |b|
      merge = b.report("Tot. Merge:  ") { run_merge_sort(arrays_to_test) }
      bubble = b.report("Tot. Bubble: ") { run_bubble_sort(arrays_to_test) }
      [merge/count, bubble/count]
    end
  end

  def self.random_arr(n)
    Array.new(n) { rand(n) }
  end

  def self.run_bubble_sort(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      bubble_sort(array_to_test)
    end
  end

  def self.run_merge_sort(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      merge_sort(array_to_test)
    end
  end

  def self.run_performance_tests(multiplier = 5, rounds = 3)
    [1, 10, 100, 1000, 10000].each do |size|
      size *= multiplier
      wait_for_keypress(
        "Press any key to benchmark sorts for #{size} elements"
      )
      performance_test(size, rounds)
    end
  end

  def self.wait_for_keypress(prompt)
    puts prompt
    STDIN.getch
  end
end

SortingDemo.run_performance_tests()
