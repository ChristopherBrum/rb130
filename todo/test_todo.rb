require 'simplecov'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
SimpleCov.start

require_relative 'todo'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.each { |todo| todo.done! }
    assert_equal(true, @list.done?)
  end

  def test_only_takes_todo_object
    assert_raises(TypeError) { @list.add(10) }
    assert_raises(TypeError) { @list.add('Hello') }
    assert_raises(TypeError) { @list.add([]) }
    assert_raises(TypeError) { @list.add(TodoList.new('Test List')) }
  end

  def test_shovel
    test_list = TodoList.new("test todo list")
    test_list << @todo1
    assert_equal([@todo1], test_list.to_a)

    test_todo = Todo.new('test todo')
    @list << test_todo
    @todos << test_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_add_error
    assert_raises(TypeError) { @list.add(1) }
  end

  def test_alias_of_add
    todo = Todo.new('Laundry')
    @list.add(todo)
    @todos << todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(@list.size) }
    assert_raises(IndexError) { @list.item_at(-@list.size - 1)  }
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo3, @list.item_at(2))
  end

  def test_mark_done_at
    assert_equal(false, @todo1.done?)
    assert_equal(true, @list.mark_done_at(0))
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
    assert_raises(IndexError) { @list.mark_done_at(@list.size) }
    assert_raises(IndexError) { @list.mark_done_at(-@list.size - 1) }
  end

  def test_mark_undone_at
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)

    assert_equal(true, @todo1.done!)
    assert_equal(true, @todo2.done!)
    assert_equal(true, @todo3.done!)

    assert_equal(true, @todo1.done?)
    assert_equal(false, @list.mark_undone_at(0))
    assert_equal(false, @todo1.done?)

    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)

    assert_raises(IndexError) { @list.mark_done_at(@list.size) }
    assert_raises(IndexError) { @list.mark_done_at(-@list.size - 1) }
  end

  def test_done!
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)

    @list.done!

    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(@list.size) }
    assert_raises(IndexError) { @list.remove_at(-@list.size - 1) }
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_to_s_with_todo_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_with_all_todos_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0

    @list.each do |todo|
      assert_equal(@todos[counter], todo)
      assert_equal(false, todo.done?)
      todo.done!
      counter += 1
    end

    assert_equal(true, @list.done?)
  end

  def test_each_for_object
    each_return = @list.each { |todo| nil }
    assert_same(@list, each_return)
  end

  def test_select
    @list.mark_done_at(2)
    selected_arr = @list.select { |todo| !todo.done? }
    assert_equal([@todo1, @todo2], selected_arr.to_a)
    refute_same(@list, selected_arr)
  end

  def test_find_by_title 
    assert_equal(@todo1, @list.find_by_title("Buy milk"))
  end

  def test_all_done
    @todo1.done!
    @todo2.done!
    assert_equal([@todo1, @todo2], @list.all_done)
  end

  def test_not_all_done
    @todo1.done!
    @todo2.done!
    assert_equal([@todo3], @list.not_all_done)
  end

  def test_mark_done
    assert_equal(true, @list.mark_done("Clean room"))
    assert_equal(true, @todo2.done?)
  end

  def mark_all_done
    assert_equal(0, @list.select { |todo| todo.done? }.size)
    assert_equal(@list, @list.mark_all_done.to_a)
    assert_equal(3, @list.select { |todo| todo.done? }.size)
  end

  def test_mark_all_undone
    assert_equal(@list.to_a, @list.mark_all_done)
    assert_equal(3, @list.select { |todo| todo.done? }.size)
    assert_same(@list.to_a, @list.mark_all_undone)
    assert_equal(0, @list.select { |todo| todo.done? }.size)
  end
end