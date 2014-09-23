class Event
  attr_accessor :id, :title, :url, :class, :start, :end, :modal, :modal_type, :modal_title

  def initialize(options = {})
    if !options.blank?
      self.id = options[:id]
      self.title = options[:title]
      self.url = options[:url]
      self.class = options[:class]
      self.start = options[:start]
      self.end = options[:end]
      self.modal = options[:modal]
      self.modal_type = options[:modal_type]
      self.modal_title = options[:modal_title]
    end
  end

  def self.uniq_id(class_name, original_id)
    "#{Zlib.crc32(class_name)}#{original_id}"
  end

  def self.day_start_to_milliseconds(date, half_day_str = "")
    if half_day_str == LeaveCredit::HALF_DAY_LEAVES[0]
      date.to_time.to_i * 1000
    elsif half_day_str == LeaveCredit::HALF_DAY_LEAVES[1]
      (date.to_time + 12*3600).to_i * 1000
    else
      date.to_time.to_i * 1000
    end
  end

  def self.day_end_to_milliseconds(date, half_day_str = "")
    if half_day_str == LeaveCredit::HALF_DAY_LEAVES[0]
      (date.to_time + 12*3600).to_i * 1000
    elsif half_day_str == LeaveCredit::HALF_DAY_LEAVES[1]
      ((date + 1).to_time - 1).to_i * 1000
    else
      ((date + 1).to_time - 1).to_i * 1000
    end
  end
end