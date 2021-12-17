class Text
  def initialize(text)
    @text = File.open('text.txt')
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end
end
