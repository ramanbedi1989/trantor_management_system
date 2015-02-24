class Leave < ActiveRecord::Base
  has_many :leave_credits

  
  class << self
  	leave_types = {earned_leave: 'Earned Leave', sick_leave: 'Sick Leave', casual_leave: 'Casual Leave'}
  	leave_types.each do |method_name, leave_name|
  		define_method(method_name){ where("name = ?", leave_name)}
  	end	
  end

  

end
