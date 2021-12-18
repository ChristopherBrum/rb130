require 'minitest/autorun'

require_relative 'text'

TEXT = <<~TEXT
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed vulputate ipsum.
  Suspendisse commodo sem arcu. Donec a nisi elit. Nullam eget nisi commodo, volutpat
  quam a, viverra mauris. Nunc viverra sed massa a condimentum. Suspendisse ornare justo
  nulla, sit amet mollis eros sollicitudin et. Etiam maximus molestie eros, sit amet dictum
  dolor ornare bibendum. Morbi ut massa nec lorem tincidunt elementum vitae id magna. Cras
  et varius mauris, at pharetra mi.
TEXT

TEXT_FILE = StringIO.new(TEXT)

class TextTest < MiniTest::Test
  def setup
    @file = File.open(TEXT_FILE, 'r')
    @text = Text.new(@file.read)
  end

  def test_swap
    actual_text = @text.swap('a', 'e')
    expected_text = <<~TEXT.chomp
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed vulputate ipsum.
      Suspendisse commodo sem arcu. Donec a nisi elit. Nullam eget nisi commodo, volutpat
      quam a, viverra mauris. Nunc viverra sed massa a condimentum. Suspendisse ornare justo
      nulla, sit amet mollis eros sollicitudin et. Etiam maximus molestie eros, sit amet dictum
      dolor ornare bibendum. Morbi ut massa nec lorem tincidunt elementum vitae id magna. Cras
      et varius mauris, at pharetra mi.
    TEXT

    assert_equal(expected_text, actual_text)
  end

  def test_word_count
    assert_equal(72, @text.word_count)
  end

  def teardown
    # @file.close
  end
end