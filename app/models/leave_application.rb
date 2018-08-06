class LeaveApplication < ApplicationRecord
  belongs_to :user

  attr_accessor :approver, :applicant

  validates :from_date, :presence => true
  validates :to_date, :presence => true
  validates :reason, :presence => true, :length => { :within => 1..100 }
  validates :approver_comment, :presence => true, unless: :apply
  validate :valid_leave_period, :if => :apply

  private

  def valid_leave_period
    unless from_date.nil? && to_date.nil?
      if from_date > to_date
        errors.add(:from_date, " can't be more than To date.")
      end
      leaves = LeaveApplication.where("user_id = ? and leave_status != 'Reject'", user_id)
      leaves.each do |leave|
        from_date.upto(to_date) do |date|
          if leave.from_date.upto(leave.to_date).include?(date)
            errors.add(:date, ": #{date} - leave already applied")
          end
        end
      end
    end
  end
  
  def apply
    leave_status == "Apply"
  end
end
