DB_ATTENDANCE = Rails.env == 'production' ? 
	YAML.load_file("#{Rails.root}/config/attendance.yml")['attendance'] :
	YAML.load_file("#{Rails.root}/config/remote_db.yml")['attendance']