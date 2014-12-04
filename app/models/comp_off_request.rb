class CompOffRequest < ActiveRecord::Base
  has_many :leave_credits
  belongs_to :user

  before_save :modify_compoff_approval
  def modify_compoff_approval
    if changed.include? "approved"
      if changes["approved"][1]
        self.rejected = false
        self.approved_date = Date.today
      end
    elsif changed.include? "rejected"
      if changes["rejected"][1]
        self.approved = false
        self.approved_date = Date.today
      end
    end
    true
  end
end
