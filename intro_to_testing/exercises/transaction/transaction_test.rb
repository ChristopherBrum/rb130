require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

require_relative 'transaction'

class TransactionTest < MiniTest::Test
  def setup
    @transaction = Transaction.new(75)
  end
  
  def test_prompt_for_payment
    str_input = StringIO.new("75\n")
    str_output = StringIO.new
    @transaction.prompt_for_payment(input: str_input, output: str_output)
    assert_equal(75, @transaction.amount_paid)
  end
end
