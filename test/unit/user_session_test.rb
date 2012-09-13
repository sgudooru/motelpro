require 'test_helper'
class UserSessionTest < ActiveSupport::TestCase
    def setup
    @user_session =UserSessionsController.new
    end

  test "logout of session" do
    usr= User.find_by_username(@user_session.user.username)
    assert((Time.now-usr.logout_time))
  end

  test "after create"do
      r=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    p= UserLog.create(:user_id=>r.id, :login_time=>Time.now.utc - (5).hours)
      p.save
    assert_equal p.login_time,Time.now.utc - (5).hours

  end
  test "before destroy"do
    r=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    p= UserLog.create(:user_id=>r.id, :login_time=>Time.now.utc - (5).hours)
    p.destroy



  end
end