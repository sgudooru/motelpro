class UserSession < Authlogic::Session::Base
  find_by_login_method :find_by_username
  logout_on_timeout false

  def after_create
    user= User.find_by_username(self.user.username)
    UserLog.create(:user_id=>user.id, :login_time=>Time.now.utc - (5).hours)
  end

  def before_destroy
    puts "current user is: #{self.user} "
    if (!self.user.user_logs.last.nil? && self.user.user_logs.last.logout_time.nil?)
      ulog=self.user.user_logs.last UserLog
      ulog.logout_time= Time.now.utc - (5).hours
      ulog.save!
    end
  end
end


