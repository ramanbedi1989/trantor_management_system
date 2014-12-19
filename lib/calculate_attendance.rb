class CalculateAttendance
  def self.calculate_and_insert(users, date_from, date_to)
    Rails.logger.info "---------------------------------------------------"
    Rails.logger.info "--> Starting fetching attendance #{Time.now}"
    Rails.logger.info "---------------------------------------------------"
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
      next unless user
      Rails.logger.info "---------------------------------------------------"
      Rails.logger.info "--> Fething attendance for #{user.username} #{user.card_no}"
      Rails.logger.info "---------------------------------------------------"
      (date_from..date_to).each do |day|
        attendance = Attendance.where(user_id: user.id, attendance_date: day).first_or_initialize
        attendance.present = present_days.include?(day)
        attendance.save
      end
    end
    Rails.logger.info "---------------------------------------------------"
    Rails.logger.info "--> Attendance data fetched!!"
    Rails.logger.info "---------------------------------------------------"
  rescue => _exception
    Rails.logger.info "---------------------------------------------------\n\n"
    Rails.logger.debug "!! Exception"
    Rails.logger.debug _exception.inspect
    Rails.logger.info "---------------------------------------------------\n\n"
    # Trigger email to admin
  end  
end