class CalculateAttendance
  def self.calculate_and_insert(users, date_from, date_to)
    attendance = UserAttendance.where("card_no IN (?) and date(time) >= ? and date(time) <= ?",users.map(&:card_no), date_from, date_to).order("DATE(time)").pluck(:card_no,"DATE(time)") 
    data = {}
    attendance.each do |att| 
      if(data[att[0]].blank?) 
        data[att[0]] = Set.new 
      end
      data[att[0]].add(att[1]) 
    end
    data.each do |card_no, present_days|
      user = User.where(card_no: card_no).first
      (date_from..date_to).each do |day|
        attendance = Attendance.where(user_id: user.id, attendance_date: day).first_or_initialize
        attendance.present = present_days.include?(day)
        attendance.save
      end
    end
  end
end