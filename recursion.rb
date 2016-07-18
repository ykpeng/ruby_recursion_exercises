def range(start_val, end_val)
  if end_val < start_val
    []
  else
    [start_val] + range(start_val + 1, end_val)
  end
end

def sum_array_recursive(arr)
  if arr.length < 1
    0
  elsif arr.length == 1
    arr[0]
  else
    arr[0] + sum_array_recursive(arr[1..-1])
  end
end

def sum_array_iterative(arr)
  arr.inject(0, :+)
end

def exp(b, n)
  if n == 0
    1
  else
    b * exp(b, n - 1)
  end
end

def exp2(b, n)
  if n == 0
    1
  else
    half = exp2(b, n /2 )
    if n.even?
      half * half
    else
      b * half * half
    end
  end
end

class Array
  def deep_dup
    copy = []
    self.each do |e|
      if e.is_a?(Array)
        copy << e.deep_dup
      else
        copy << e
      end
    end
    copy
  end
end

def fib_recursive(n)
  if n < 3
    [0, 1].take(n)
  else
    last_fibs = fib_recursive(n - 1)
    new_fib = last_fibs[-1] + last_fibs[-2]
    last_fibs << new_fib
  end
end

def fib_iterative(n)
  res = [0, 1]

  if n < 3
    res = res.take(n)
  end

  while res.length < n
    new_fib = res[-1] + res[-2]
    res << new_fib
  end

  res
end

def bsearch(array, target)
  if array.length == 0
    return nil
  end

  mid_idx = array.length / 2
  if array[mid_idx] == target
    return mid_idx
  else
    if array[mid_idx] > target
      return bsearch(array[0...mid_idx], target)
    else
      idx = bsearch(array[mid_idx + 1..-1], target)
      if idx
        return (mid_idx + 1) + idx
      else
        nil
      end
    end
  end
end

def bsearch_include?(arr, target)
  if arr.length == 0
    return false
  else
    mid_idx = arr.length / 2
    if arr[mid_idx] == target
      return true
    elsif arr[mid_idx] > target
      bsearch_include?(arr[0...mid_idx], target)
    else
      bsearch_include?(arr[mid_idx + 1..-1], target)
    end
  end
end

def bsearch_include2?(arr, target)
  if arr.length == 0
    return false
  end

  mid_idx = arr.length / 2
  if arr[mid_idx] == target
    return true
  end

  if arr[mid_idx] > target
    bsearch_include?(arr[0...mid_idx], target)
  else
    bsearch_include?(arr[mid_idx + 1..-1], target)
  end
end

# p bsearch_include?([1, 2, 3], 1) # => 0
# p bsearch_include?([2, 3, 4, 5], 3) # => 1
# p bsearch_include?([2, 4, 6, 8, 10], 6) # => 2
# p bsearch_include?([1, 3, 4, 5, 9], 5) # => 3
# p bsearch_include?([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch_include?([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch_include?([1, 2, 3, 4, 5, 7], 6) # => nil

class Array
  def merge_sort
    if self.length < 2
      return self
    end

    mid_idx = self.length / 2
    left = self.take(mid_idx).merge_sort
    right = self.drop(mid_idx).merge_sort

    self.class.merge(left, right)
  end

  def self.merge(left, right)
    merged = []

    until left.empty? || right.empty?
      if left.first < right.first
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right
  end

  def subsets
    if self.length == 0
      return [[]]
    end

    prev_subs = self[0..-2].subsets
    new_subs = prev_subs.map do |sub_arr|
      sub_arr + [self[-1]]
    end

    return prev_subs + new_subs
  end
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def make_change(amount, coins)
  if amount == 0
    return []
  end

  sorted_coins = coins.sort.reverse
  if amount < sorted_coins[-1]
    return nil
  end

  best_change = nil
  sorted_coins.each_with_index do |coin, idx|
    next if coin > amount

    remainder = amount - coin
    best_remainder_change = make_change(remainder, coins.drop(idx))

    next if best_remainder_change.nil?
    curr_change = [coin] + best_remainder_change

    if best_change.nil? || curr_change.length < best_change.length
      best_change = curr_change
    end

  end

  return best_change
end

# p make_change(14, [1, 10, 7])
# p make_change(24, [10, 7, 1])

# p make_best_change(14, [1, 10, 7])
# p make_best_change(24, [10, 7, 1])
