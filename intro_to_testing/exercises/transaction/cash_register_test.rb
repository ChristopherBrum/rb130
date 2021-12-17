require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test

  def setup
    @register = CashRegister.new(1000)
    @transaction = Transaction.new(75)
    @transaction.amount_paid = 100
  end

  def test_accept_money
    original_reg_balance = @register.total_money
    @register.accept_money(@transaction)
    updated_reg_balance = @register.total_money

    assert_equal(original_reg_balance + 100, updated_reg_balance)
  end

  def test_change
    paid = @transaction.amount_paid
    cost = @transaction.item_cost
    change_expected = paid - cost

    assert_equal(change_expected, @register.change(@transaction))
    assert_equal(25, @register.change(@transaction))
  end
  
  def test_give_receipt
    assert_output("You've paid $75.\n") { @register.give_receipt(@transaction) }
    
    @transaction = Transaction.new(200)
    assert_output("You've paid $200.\n") { @register.give_receipt(@transaction) }
  end
end