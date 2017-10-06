require 'byebug'

class Array

  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end
  end

  def my_select(&prc)
    result = []
    self.my_each do |i|
      if prc.call(i)
        result << i
      end
    end
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each do |i|
      if prc.call(i) == false
        result << i
      end
    end
    result
  end

  def my_any?(&prc)
    self.my_each do |i|
      if prc.call(i)
        return true
      end
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |i|
      if prc.call(i) == false
        return false
      end
    end
    true
  end

  def my_flatten
    result = []
    self.my_each do |i|
      if i.is_a?(Array)
        result.concat(i.my_flatten)
      else
        result << i
      end
    end
    result
  end

  def my_zip(*args)
    result = []
    temp = []

    self.each_index do |i|
      temp << self[i]

      args.my_each do |array|
        temp << array[i]
      end

      result << temp
      temp = []
    end

    result
  end

  def my_rotate(n = 1)
    if n > 0
      self.drop(n % self.length) + self.take(n % self.length)
    elsif n < 0
      self.drop(self.length - (n * -1) % self.length) + self.take(self.length - (n * -1)  % self.length)
    end
  end

  def my_join(string = "")
    str = ""
    self.my_each do |i|
      str += i
      str += string
    end
    if string == ""
      str
    else
      str[0...str.length - 1]
    end
  end

  def my_reverse
    result = []
    array = self.dup
    until array.empty?
      result << array.pop
    end
    result
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new {|a,b| a <=> b}

    sorted = false

    while !sorted
      sorted = true
      (0...self.length-1).each do |i|
        if prc.call(self[i], self[i+1]) == 1
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    array = self.dup
    prc ||= Proc.new {|a,b| a <=> b}

    sorted = false

    while !sorted
      sorted = true
      (0...array.length-1).each do |i|
        if prc.call(array[i], array[i+1]) == 1
          array[i], array[i+1] = array[i+1], array[i]
          sorted = false
        end
      end
    end

    array
  end
end

def factors(num)
  (1..num).select {|i| num % i == 0}
end

def substrings(string)
  result = []
  (0...string.length).each do |i|
    (0...string.length).each do |j|
      result << string[i..j]
    end
  end
  result.select { |i| i != "" }
end

def subwords(word, dictionary)
  substrings(word) & dictionary
end


p subwords('cat', ['cat', 'at'])
