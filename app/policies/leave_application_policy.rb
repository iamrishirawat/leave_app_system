class LeaveApplicationPolicy < ApplicationPolicy

  attr_reader :user, :record

  def new?
    @user.applicant?
  end
  
  def create?
    @user.applicant?
  end

  def index?
    @user.applicant?
  end
  
  def show?
    @user.applicant?
  end
  
  def edit?
    @user.approver?
  end
  
  def update?
    @user.approver?
  end
  
  def action_history?
    @user.approver?
  end
  
  def worklist?
    @user.approver?
  end

  def show_action?
    @user.approver?
  end
  
end
