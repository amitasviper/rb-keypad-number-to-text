require 'rspec'
require_relative '../src/mnemonic_generator'

describe MnemonicGenerator do

  let(:mnemonic_generator)     { MnemonicGenerator.new }

  it 'should be able to find all mnemonics of 2223333' do
    words = %w(AAA AAAA DDDD DDDDD)
    mnemonic = [["AAA", "DDDD"]]
    words.each do |word|
      mnemonic_generator.add_word(word)
    end
    expect(mnemonic_generator.find_mnemonic('2223333')).to eq(mnemonic)
  end


  it 'should be able to find all mnemonics of 6686787825' do
    words = %w(MOTORTRUCK NOUN STRUCK ONTO MOTOR TRUCK USUAL NOUNS APPLE BANANA)
    mnemonic = [%w(NOUN STRUCK), %w(ONTO STRUCK), %w(MOTOR TRUCK), %w(MOTOR USUAL), %w(NOUNS TRUCK), %w(NOUNS USUAL), %w(MOTORTRUCK)]
    words.each do |word|
      mnemonic_generator.add_word(word)
    end
    expect(mnemonic_generator.find_mnemonic('6686787825')).to eq(mnemonic)
  end

end