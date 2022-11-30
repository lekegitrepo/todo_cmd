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
    new_task = ARGV.shift

    File.open(TODO_FILE, 'a') do |file|
      write_todo(file, new_task)
      puts 'New task added.'
    end
  when 'list'
  when 'done'
  end
end
