class CreateLeaveApplications < ActiveRecord::Migration[5.1]
  def up
    create_table :leave_applications do |t|
      t.integer "user_id"
      t.date "from_date", :null => false
      t.date "to_date", :null => false
      t.integer "total_leaves", :default => 0
      t.integer "approver_user_id", :null => false
      t.text "reason", :null => false
      t.text "approver_comment"
      t.string "leave_status"
      t.timestamps
    end
    add_index :leave_applications, :user_id
  end
  
  def down
    drop_table :leave_applications
  end
end
