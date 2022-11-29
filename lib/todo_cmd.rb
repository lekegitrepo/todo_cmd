# frozen_string_literal: true

require_relative "todo_cmd/version"

module TodoCmd
  class Error < StandardError; end
  
  TODO_FILE = 'todo.txt'

  def read_todo(line)
    line.chomp.split(/,/)
  end
  
  def write_todo(file, name, created = Time.now, completed = '')
    file.puts "#{name}, #{created}, #{completed}"
  end

  command = ARGV.shift

  case command
  when 'new'
  when 'list'
  when 'done'
  end
end
