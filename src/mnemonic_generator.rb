#Responsible for finding matching words for a given phone number
class MnemonicGenerator
  def initialize(min_word_length=3)
    @indexed_data = {}
    @min_word_length = min_word_length
  end

  def add_word(word)
    phone_number = word_mapping(word)
    if @indexed_data.has_key?(phone_number)
      @indexed_data[phone_number].push(word)
    else
      @indexed_data[phone_number] = [word]
    end
  end

  def find_mnemonic(phone_number)
    combinations = number_combinations(phone_number)
    phrases_for_all_combinations(combinations)
  end

  private
  def number_combinations(number)
    combinations = []
    (number.length - 2 * @min_word_length + 1).times do |index|
      prefix = number[0...index + @min_word_length]
      suffix = number[index + @min_word_length..-1]
      combinations.push([prefix, suffix]) if valid_combination?([prefix, suffix]) == true
    end
    combinations.push([number]) if valid_combination?([number]) == true
    combinations
  end

  def valid_combination?(number_parts)
    number_parts.all? {|number_part| @indexed_data.has_key? number_part}
  end

  def phrases_for_all_combinations(combinations)
    phrases = []
    combinations.each do |combination|
      phrases.concat(phrases_for_number(combination))
    end
    phrases
  end

  def phrases_for_number(number_parts)
    phrases = []
    number_parts.each do |number_part|
      phrases.push(@indexed_data[number_part])
    end
    phrases[0].product(*phrases[1..-1])
  end

  def word_mapping(word)
    number = ''
    word.split('').each do |letter|
      number += letter_mapping(letter)
    end
    number
  end

  def letter_mapping(letter)
    letter = letter.upcase
    return '2' if 'ABC'.include? letter
    return '3' if 'DEF'.include? letter
    return '4' if 'GHI'.include? letter
    return '5' if 'JKL'.include? letter
    return '6' if 'MNO'.include? letter
    return '7' if 'PQRS'.include? letter
    return '8' if 'TUV'.include? letter
    return '9' if 'WXYZ'.include? letter
  end
end