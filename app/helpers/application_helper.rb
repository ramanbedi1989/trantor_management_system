module ApplicationHelper
  def format_date(datetime)
    datetime.strftime("%d %b %Y")
  end

  def show_leaves(leave_info)
    total = Hash.new(0)
    leave_info.leave_credits.each do |lc|
      if lc.half_day_leave
        total[lc.leave.name] += 0.5
      else
        total[lc.leave.name] += 1
      end
    end
    leave_info.loss_of_pay_infos.each do |lop|
      total[lop.loss_of_pay.name] += 1
    end
    content_tag(:div) do
      total.map do |k,v|
        content_tag(:div) do 
          "#{k}: #{v}"
        end
      end.join.html_safe
    end
  end
end
