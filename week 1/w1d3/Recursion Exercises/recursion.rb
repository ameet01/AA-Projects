def range(start, last)
  return [] if last - 1 < start
  [start] + range(start + 1, last)
end

def sum_array(arr)
  sum = 0
  arr.each do |e|
    sum += e
  end
  sum
end

def sum_array_r(arr)
  return 0 if arr.length == 0
  arr.first + sum_array_r(arr[1..-1])
end

def exp1(n, p)
  return 1 if p == 0
  return nil if p < 0
  n * exp1(n, p - 1)
end

def exp2(n, p)
  return 1 if p == 0
  return n if p == 1
  return nil if p < 0
  if p.even?
    exp2(n, p / 2) ** 2
  else
    n * (exp2(n, (p - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    result = []
    self.each do |i|
      if i.is_a?(Array)
        result << i.deep_dup
      else
        result << i
      end
    end
    result
  end
end

def fibonacci_iterative(n)
  result = []
  n.times do |i|
    if i == 0 || i == 1
      result << 1
    else
      result << result.last + result[-2]
    end
  end
  result
end

def fibonacci_recursive(n)
  return [1] if n == 1
  return [1,1] if n == 2
  return nil if n < 1
  num = fibonacci_recursive(n-1)
  num << num.last + num[-2]
  num
end

def subsets(array)
  return [[]] if array.empty?
  first_set = subsets(array[0..-2])
  last_set = []
  first_set.each do |e|
    el = e.deep_dup << array.last
    last_set << el
  end
  first_set + last_set
end

def permutations(array)
  return [array] if array.length <= 1
  first = array.shift
  subs = permutations(array)
  result = []
  subs.each do |i|
    (0..i.length).each do |j|
      result << i[0...j] + [first] + i[j..-1]
    end
  end
  result
end

def binary_search(array, target)
  return nil if !array.include?(target)
  middle = array.length / 2

  if array[middle] == target
    return middle
  elsif array[middle] > target
    binary_search(array[0..middle - 1], target)
  elsif array[middle] < target
    middle + 1 + binary_search(array[middle + 1..-1], target)
  end
end

class Array
  def merge_sort
    return self if self.length < 2
    middle = self.length / 2
    left = self.take(middle)
    right = self.drop(middle)
    merge(left.merge_sort, right.merge_sort)
  end

  def merge(left, right)
    result = []

    until left.empty? || right.empty?
      if left.first < right.first
        result << left.shift
      else
        result << right.shift
      end
    end

    result + left + right
  end
end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  result = []

  biggest_coin = coins.shift

  (amount / biggest_coin).times do |i|
    result << biggest_coin
    amount -= biggest_coin
  end

  result + make_change(amount, coins)
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  best = nil

  coins = coins.sort.reverse
  coins.each_with_index do |i, j|
    next if i > amount
    current_coin = i
    best_remainder = make_better_change(amount - current_coin, coins.drop(j))
    next if best_remainder.nil?
    result = [current_coin] + best_remainder
    p result
    if (best.nil? || best.count > result.count)
      best = result
    end
  end

  best
end
