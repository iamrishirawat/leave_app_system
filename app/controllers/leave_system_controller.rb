class LeaveSystemController < ApplicationController

  before_action :validate

  def new
    @admins = []
    admins_obj = User.where(" role = 'Admin'")
    admins_obj.each do |a|
      @admins << [a.first_name + " " + a.last_name, a.id]
    end
    @user = User.find_by_id(session[:user_id])
  end

  def create
    errors = []
    leave = LeaveApplication.new(get_params)
    leave.user_id = current_user.id
    leave.leave_status = 'Apply'
    if leave.valid?
      from = nil
      leave.from_date.upto(leave.to_date) do |date|
        if date.sunday? || date.saturday?
          next
        else
          if from.nil?
            from = date
          end
          leave.total_leaves +=1
          leave.to_date = date
        end
      leave.from_date = from
      end
      if leave.save
        flash[:notice] = ["Leave applied successfully."]
        redirect_to leave_system_index_path
      else
        flash[:error] = leave.errors.full_messages
        redirect_to new_leave_system_path
      end
    else
      flash[:error] = leave.errors.full_messages
      redirect_to new_leave_system_path
    end
  end

  # Will incoporate it later
  # def show_balance
  # end

  # For applicant
  def index
    @leaves = LeaveApplication.where("user_id = ?", current_user.id)
    @leaves.each do |leave|
      leave.approver = User.find_by_id(leave.approver_user_id)
    end
  end

  # For applicant
  def show
    @leave = LeaveApplication.find_by_id(params[:id])
    @leave.approver = User.find_by_id(@leave.approver_user_id)
  end

  # For approver to approve/cancel the request
  def edit
    @leave = LeaveApplication.find_by_id(params[:id])
    @leave.applicant = User.find_by_id(@leave.user_id)
  end

  # Approver update action
  def update
    leave = LeaveApplication.find_by_id(params[:id])
    leave.approver_comment = get_edit_params[:approver_comment]
    leave.leave_status = get_edit_params[:leave_status]
    if leave.valid? && leave.save
      flash[:notice] = ["Record updated successfully."]
      redirect_to leave_system_worklist_path
    else
      flash[:error] = leave.errors.full_messages
      redirect_to edit_leave_system_path
    end
  end

  # For approver
  def action_history
    @leaves = LeaveApplication.where("approver_user_id = ? and (leave_status = 'Approve' || leave_status = 'Reject')  ", current_user.id)
      @leaves.each do |leave|
        leave.applicant = User.find_by_id(leave.user_id)
      end
  end

  # For approver
  def worklist
    @leaves = LeaveApplication.where("approver_user_id = ? and leave_status = 'Apply'", current_user.id)
    @leaves.each do |leave|
      leave.applicant = User.find_by_id(leave.user_id)
    end
  end
  
  def show_action
    @leave = LeaveApplication.where("id = ?", params[:id]).first
    @leave.applicant = User.find_by_id(@leave.user_id)
  end
  
  private

  def validate
    unless user_signed_in?
      flash[:error] = "Please log in first."
      redirect_to new_user_session_path
    end
  end

  def get_params
    params.require(:leave).permit(:from_date, :to_date, :approver_user_id, :reason)
  end

  def get_edit_params
    params.require(:leave_application).permit(:approver_comment, :leave_status)
  end
end
