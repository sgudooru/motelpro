class UserLogMigration < ActiveRecord::Migration
  def self.up
    create_table :user_logs do |t|
      t.integer :user_id
      t.datetime :login_time
      t.datetime :logout_time
      t.timestamps
    end
    UserLog.create(:user_id=>1, :login_time=>Time.now+ (-3).hours, :logout_time=>Time.now+ (-2).hours)
  end

  def self.down
    drop_table :user_logs
  end
end
