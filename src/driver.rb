require_relative '../src/mnemonic_generator'

#Respnsible for interacting with the mnemonic generator
class Driver
  def initialize
    @generator = MnemonicGenerator.new
  end

  def add_words_from_file(filename='dictionary.txt')
    File.readlines(filename).each do |word|
      @generator.add_word(sanitize_word(word))
    end
  end

  def find_mnemonic(phone_number)
    phone_number = phone_number.to_s
    puts "#{@generator.find_mnemonic(phone_number)}"
  end

  private
  def sanitize_word(word)
    word.strip.upcase
  end

end

def start_execution
  driver = Driver.new
  driver.add_words_from_file
  driver.find_mnemonic(6686787825)
  driver.find_mnemonic(2282668687)
end

start_execution