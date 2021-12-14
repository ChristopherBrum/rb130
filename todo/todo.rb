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

  def shift
    todos.shift
  end

  def pop
    todos.pop
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

  def remove_at(index)
    todos.delete(item_at(index))
  end

  def to_s
    str = "---- Today's Todos ----\n"
    str << todos.map(&:to_s).join("\n")
    str
  end

  def to_a
    todos
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

  def find_by_title(search_title)
    todos.each do |todo|
      return todo if todo.title == search_title
    end
    
    nil
  end

  def all_done
    todos.select { |todo| todo.done? }
  end

  def not_all_done
    todos.select { |todo| !todo.done? }
  end

  def mark_done(search_title)
    todo_match = find_by_title(search_title)

    if todo_match
      mark_done_at(todos.index(todo_match))
    end
  end
  
  def mark_all_done
    todos.each { |todo| todo.done! }
  end

  def mark_all_undone
    todos.each { |todo| todo.undone! }
  end

  private

  attr_accessor :todos

end
