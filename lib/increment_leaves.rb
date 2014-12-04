class IncrementLeaves
  def self.increment_earned_leaves(users, number)
    users.each do |u|
      number.times do
        LeaveCredit.create(user_id: u.id, leave_id: Leave.where(name: SeedData["leaves"][2]).first.id), leave_credited_date: Date.today)
      end
    end
  end
end