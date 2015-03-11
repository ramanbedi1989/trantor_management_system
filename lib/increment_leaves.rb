class IncrementLeaves

	class << self
	  
	  #EARNED LEAVES
	  def increment_earned_leaves(users, number)
	    users.each do |u|
	      number.times do
	      	leave_id = Leave.where(name: SeedData["leaves"][2]).first.id
	      	raise "Leave type does not fetched" unless leave_id
	        LeaveCredit.create({
	        					user_id: u.id, 
	        				    leave_id: leave_id,
	        				    leave_credited_date: Date.today
		    })
	      end
	    end
	  end

	  #CASUAL LEAVES
	  def increment_casual_leaves(users, number)
	  	 users.each do |u|
	      number.times do
	      	leave_id = Leave.where(name: SeedData["leaves"][1]).first.id
	      	raise "Leave type does not fetched" unless leave_id
	        LeaveCredit.create({
	        					user_id: u.id, 
	        				    leave_id: leave_id,
	        				    leave_credited_date: Date.today
		    })
	      end
	    end
	  end

	  # SICK LEAVES
	  def increment_sick_leaves(users, number)
	  	 users.each do |u|
	      number.times do
	      	leave_id = Leave.where(name: SeedData["leaves"][0]).first.id
	      	raise "Leave type does not fetched" unless leave_id
	        LeaveCredit.create({
	        					user_id: u.id, 
	        				    leave_id: leave_id,
	        				    leave_credited_date: Date.today
	       })
	      end
	    end
	  end

	end

end