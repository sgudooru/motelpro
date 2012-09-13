require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_attrs = {:username=>"test", :password=>"testpwd", :password_confirmation=>"test1pwd", :admin=>"f", :first_name=>"test", :last_name=>"user", :contactno=>"9949566523", :email=>"sa@gmail.com"}
    User.create(@user_attrs)
    @user=User.last
  end

  test "Creating a new User" do
    c = User.count
    @user_attrs={:username=>"test1", :password=>"test1pwd", :password_confirmation=>"test1pwd", :admin=>"f", :first_name=>"test", :last_name=>"user", :contactno=>"9949566523", :email=>"sa@gmail.com"}
    User.create(@user_attrs)
    @user=User.last
    assert_equal c+1, User.count
  end
  test "cannot create a new User without first name" do
    c = User.count
    User.create(:username=>"sumang", :password=>"saikumar", :password_confirmation=>"saikumar", :admin=>"f", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    assert_equal c, User.count
  end
  test "cannot create a new User without last name" do
    c = User.count
    User.create(:username=>"sumang", :password=>"saikumar", :password_confirmation=>"saikumar", :admin=>"f", :first_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    assert_equal c, User.count
  end
  test "User name already exists" do
    c = User.count
    User.create(:username=>"sumang", :password=>"saikumar", :password_confirmation=>"saikumar", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    User.create(:username=>"sumang", :password=>"saikumari", :password_confirmation=>"saikumari", :admin=>"f", :first_name=>"sumanmmm", :last_name=>"guu", :contactno=>"9949566523", :email=>"sa@gmail.com")
    assert_equal c+1, User.count
  end

  test "cannot create a new User without contact no" do
    c = User.count
    User.create(:username=>"sumang", :password=>"saikumar", :password_confirmation=>"saikumar", :admin=>"f", :first_name=>"suman", :last_name=>"g", :email=>"sa@gmail.com")
    assert_equal c, User.count
  end
  test "user name should only have alphabets" do
    @user.username="ada*$"
    assert !@user.valid?
  end

  test "last name should only have alphabets" do
    @user.last_name = "safsalf434"
    assert !@user.valid?
  end
  test "first name should only have alphabets" do
    @user.first_name = "safsalf434"
    assert !@user.valid?
  end

  test "Update User" do
    @user.first_name = "yudhi"
    assert @user.save!
  end

  test "Delete User" do
    c= User.count
    @user.destroy
    assert_equal c-1, User.count
  end
  test "full name" do
    c = User.count
    @user=User.create(:username=>"sumang", :password=>"saikumar", :password_confirmation=>"saikumar", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    v=@user.full_name
    assert_equal "g,suman",v
  end

  test "todays amount" do
    usr=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    cust=Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")
    rm= Room.create(:number=> '504', :description=>'TestRoom', :charges_per_hr=>20.0, :amount_charged=>40)
    ck=Checkin.create(:user_id=> usr.id, :room_id=>rm.id, :customer_id=>cust.id, :check_in=>Time.now, :no_of_hrs=>2, :amount_charged=>30)
    puts "amount: #{ck.amount_charged}"
    assert_equal rm.charges_per_hr*ck.no_of_hrs, usr.todays_expected_amount
    assert_equal ck.amount_charged, usr.todays_actual_amount

    ck.destroy
    rm.destroy
    cust.destroy
    usr.destroy
  end

  test "has many user logs " do

  r=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
  log=UserLog.create(:userid=>r.id,:check_in=>"2011-07-05 22:24:00.000000", :check_out=>"2011-07-06 17:22:00.000000")
    assert log.save

  end

  test "actual amount by date "do

    usr=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
      cust=Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")
     rm= Room.create(:number=> '504', :description=>'TestRoom', :charges_per_hr=>20.0, :status_id =>"1")
    ck=Checkin.create(:user_id=> usr.id, :room_id=>rm.id, :customer_id=>cust.id, :check_in=>Time.now, :no_of_hrs=>2)
    assert_equal usr.actual_amount_by_date("10/07/2010"),20
  end
end
