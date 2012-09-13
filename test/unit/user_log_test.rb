require 'test_helper'

class User_logTest < ActiveSupport::TestCase
r=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
  log=UserLog.create(:userid=>r.id,:check_in=>"2011-07-05 22:24:00.000000", :check_out=>"2011-07-06 17:22:00.000000")
end
