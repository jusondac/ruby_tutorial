#!/usr/bin/env ruby
# Beginner Example: Simple To-Do List Manager
# Demonstrates: Arrays, hashes, loops, methods, user input

class TodoList
  def initialize
    @tasks = []
    @completed_tasks = []
  end
  
  def display_menu
    puts "\n=== Simple To-Do List Manager ==="
    puts "1. Add task"
    puts "2. View tasks"
    puts "3. Complete task"
    puts "4. View completed tasks"
    puts "5. Delete task"
    puts "6. Exit"
    print "Choose an option (1-6): "
  end
  
  def add_task
    print "Enter a new task: "
    task = gets.chomp
    
    if task.empty?
      puts "Task cannot be empty!"
      return
    end
    
    @tasks << {
      id: @tasks.length + @completed_tasks.length + 1,
      description: task,
      created_at: Time.now.strftime("%Y-%m-%d %H:%M")
    }
    
    puts "Task '#{task}' added successfully!"
  end
  
  def view_tasks
    if @tasks.empty?
      puts "No pending tasks!"
      return
    end
    
    puts "\n=== Pending Tasks ==="
    @tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task[:description]} (ID: #{task[:id]}) - Created: #{task[:created_at]}"
    end
  end
  
  def complete_task
    return puts "No tasks to complete!" if @tasks.empty?
    
    view_tasks
    print "Enter task number to complete: "
    task_number = gets.chomp.to_i
    
    if task_number < 1 || task_number > @tasks.length
      puts "Invalid task number!"
      return
    end
    
    completed_task = @tasks.delete_at(task_number - 1)
    completed_task[:completed_at] = Time.now.strftime("%Y-%m-%d %H:%M")
    @completed_tasks << completed_task
    
    puts "Task '#{completed_task[:description]}' completed!"
  end
  
  def view_completed_tasks
    if @completed_tasks.empty?
      puts "No completed tasks!"
      return
    end
    
    puts "\n=== Completed Tasks ==="
    @completed_tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task[:description]} (ID: #{task[:id]})"
      puts "   Created: #{task[:created_at]} | Completed: #{task[:completed_at]}"
    end
  end
  
  def delete_task
    return puts "No tasks to delete!" if @tasks.empty?
    
    view_tasks
    print "Enter task number to delete: "
    task_number = gets.chomp.to_i
    
    if task_number < 1 || task_number > @tasks.length
      puts "Invalid task number!"
      return
    end
    
    deleted_task = @tasks.delete_at(task_number - 1)
    puts "Task '#{deleted_task[:description]}' deleted!"
  end
  
  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      
      case choice
      when 1
        add_task
      when 2
        view_tasks
      when 3
        complete_task
      when 4
        view_completed_tasks
      when 5
        delete_task
      when 6
        puts "Thank you for using To-Do List Manager!"
        break
      else
        puts "Invalid option! Please choose 1-6."
      end
    end
  end
end

# Run the program
if __FILE__ == $0
  todo_list = TodoList.new
  todo_list.run
end
