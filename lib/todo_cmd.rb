# frozen_string_literal: true

require_relative 'todo_cmd/version'

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
    File.open(TODO_FILE, 'r') do |file|
      counter = 1
      file.readlines.each do |line|
        name, created, completed = read_todo(line)
        printf("%3d - %s\n", counter, name)
        printf("  created : %s\n", created)

        printf("  completed : %s\n", completed) unless completed.nil?
        counter += 1
      end
    end
  when 'done'
    task_number = ARGV.shift.to_i

    File.open(TODO_FILE, 'r') do |file|
      File.open("#{TODO_FILE}.new", 'w') do |new_file|
        counter = 1
        name, created, completed = read_todo(file)

        if counter == task_number
          write_todo(new_file, name, created, Time.now)
          puts "Task #{counter} completed"
        else
          write_todo(new_file, name, created, completed)
        end
        counter += 1
      end
    end
  end
  `mv #{TODO_FILE}.new #{TODO_FILE}`
end
