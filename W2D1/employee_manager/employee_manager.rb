class Employee
  attr_reader :salary
  
   def initialize(name, salary, title, boss)
     @name = name
     @salary = salary
     @title = title
     @boss = boss
     @boss.employees.push(self) unless @boss.nil?
   end
   
   def bonus(multiplier)
     @salary * multiplier
   end
end

class Manager < Employee
  attr_reader :employees
  
  def initialize(name, salary, title, boss, employees = [])
    super(name, salary, title, boss)
    @employees = employees
  end
  
  def bonus(multiplier)
    subordinates_sum * multiplier
  end
  
  def subordinates_sum
    @employees.reduce(0) do |memo, employee| 
      if employee.is_a?(Manager)
        memo + employee.salary + employee.subordinates_sum
      else 
        memo + employee.salary
      end
    end
  end
end

ned = Manager.new("Ned", 1_000_000, 'Founder', nil)
darren = Manager.new("Darren", 78_000, 'TA Manager', ned)
shawna = Employee.new("Shawna", 12_000, 'TA', darren)
david = Employee.new("David", 10_000, 'TA', darren)

puts ned.subordinates_sum
puts ned.bonus(5) == 500_000
puts darren.bonus(4) == 88_000
puts david.bonus(3) == 30_000
