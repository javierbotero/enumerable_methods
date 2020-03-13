# rubocop:disable Style/CaseEquality
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def change_self
    Array self if self.class == Range
  end

  def my_each
    my_array = change_self
    return to_enum unless block_given?

    i = 0
    while i < my_array.length
      yield my_array[i]
      i += 1
    end
    my_array
  end

  def my_each_with_index
    my_array = change_self
    return to_enum unless block_given?

    i = 0
    while i < my_array.length
      yield my_array[i], i
      i += 1
    end
    my_array
  end

  def my_select
    my_array = change_self
    return to_enum unless block_given?

    arr = []
    i = 0
    while i < my_array.length
      arr.push(my_array[i]) if yield my_array[i]
      i += 1
    end
    arr
  end

  def my_all?(word = nil)
    my_array = change_self
    if block_given?
      my_array.my_each { |item| return false unless yield item }
      true
    elsif word
      my_array.my_each { |item| return false unless n === item }
      true
    else
      my_all? { |item| item }
    end
  end

  def my_any?(regex = false)
    my_array = change_self
    if block_given?
      my_array.my_each { |item| return true if yield item }
      false
    elsif regex
      my_array.my_each { return true if regex === my_array[i] }
      false
    else
      my_any? { |item| item }
    end
  end

  def my_none?(regex = false)
    my_array = change_self
    if block_given?
      my_array.my_each { |item| return false if yield item }
      true
    elsif regex
      my_array.my_each { |item| return false if regex === item }
      true
    else
      my_none? { |item| item }
    end
  end

  def my_count(item = false)
    my_array = change_self
    counter = 0
    if block_given?
      my_array.my_each { |elem| counter += 1 if yield elem }
      counter
    elsif item
      my_array.my_each { |elem| counter += 1 if elem == item }
      counter
    else
      my_array.length
    end
  end

  def my_map(proc = false)
    my_array = change_self
    arr = []
    if block_given?
      my_array.my_each { |item| arr.push(yield item) }
      arr
    elsif proc
      my_array.my_each { |item| arr.push(proc.call(item)) }
      arr
    else
      to_enum
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def my_inject(memo = false, symbol = false)
    my_array = change_self
    if memo && symbol
      my_array.my_each { |item| memo = memo.send(symbol, item) }
      memo
    elsif memo && block_given?
      my_array.my_each { |item| memo = yield memo, item }
      memo
    elsif memo.class == Symbol
      sum = 0
      my_array.my_each { |item| sum = sum.send(memo, item) }
      sum
    elsif memo.class == Integer
      my_array.my_each { |item| memo += item }
      memo
    else
      memo = 0
      my_array.my_each { |item| memo = yield item }
      memo
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/ModuleLength

arr = [1, 2, 3, 4]

def multiply_els(els)
  els.my_inject(:*)
end

puts multiply_els(arr)

# rubocop:enable Style/CaseEquality
