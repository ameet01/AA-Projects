require 'set'

class WordChainer
  attr_accessor :path

  def initialize
    @path = []
    @dictionary = Set.new(File.readlines(ARGV[0]).map(&:chomp))
  end

  def adjacent_words(word)
    array = @dictionary.select do |i|
      i.length == word.length && exact_matches(word, i) == word.length - 1
    end
    array
  end

  def exact_matches(word1, word2)
    result = 0
    word1.length.times do |i|
      result += 1 if word1[i] == word2[i]
    end
    result
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty?
      @current_words = explore_current_words
      break if @all_seen_words.include?(target)
    end

    build_path(target)
    print_path(target, @path)
  end

  def print_path(target, path)
    array = path.unshift(target)
    p array
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        if !@all_seen_words.include?(adj_word)
          new_current_words << adj_word
          @all_seen_words[adj_word] = word
        end
      end
    end
    new_current_words
  end

  def build_path(target)

    until @all_seen_words[target] == nil
      @path << @all_seen_words[target]
      target = @all_seen_words[target]
    end
  end

end


if $PROGRAM_NAME == __FILE__
  chain = WordChainer.new
  chain.run('duck', 'push')
end
