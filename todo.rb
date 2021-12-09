# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def add(todo)
    begin
      validate_todo(todo)
    rescue RuntimeError => e
      puts e.message
    end

    self.todos << todo
  end

  def validate_todo(todo)
    raise TypeError.new("Can only add Todo objects") unless todo.instance_of? Todo
  end

  def <<(todo)
    add(todo)
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    todos.fetch(index).done!
  end

  def mark_undone_at(index)
    todos.fetch(index).undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    todos.delete_at(item_at(index))
  end

  def to_s
    str = "---- Today's Todos ----\n"
    str << todos.map(&:to_s).join("\n")
    str
  end

  def each
    counter = 0

    while counter < todos.size
      yield(todos[counter])

      counter += 1
    end

    self
  end

  def select
    selected = TodoList.new('selected todos')

    todos.each do |todo|
      selected << todo if yield(todo)
    end

    selected
  end

  private

  attr_accessor :todos

end
