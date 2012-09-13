require 'test_helper'

class CheckinTest < ActiveSupport::TestCase

  def setup
    @cust=Customer.create(:first_name => "Test", :last_name => 'Customer', :contact_no => "9949501098")
    @Checkin = Checkin.first
  end

  test "Creating a new Checkin" do
    c = Checkin.count
    @room= Room.create(:number =>"302", :description => 'single bed', :charges_per_hr => "20", :status_id =>"1")
    ck=Checkin.new(:user_id=>1, :customer_id=>@cust.id, :room_id=>@room.id, :check_in=>"2011-07-05 22:24:00.000000", :no_of_hrs=>5, :amount_charged=>100.0)
    ck.save!
    assert_equal c+1, Checkin.count
  end

  test "cannot create a new Checkin without checkin time empty" do
    c = Checkin.count
    Checkin.create(:user_id=>"1", :customer_id=>@cust.id, :room_id=>"1", :check_out=>"2011-07-06 17:22:00.000000", :no_of_hrs=>5, :amount_charged=>100.0)
    assert_equal c, Checkin.count
  end
  test "cannot create a new Checkin without no of hours" do
    c = Checkin.count
    Checkin.create(:user_id=>"1", :customer_id=>@cust.id, :room_id=>"1", :check_in=>"2011-07-05 22:24:00.000000", :amount_charged=>100.0)
    assert_equal c, Checkin.count
  end
  test "cannot create a new Checkin without customer" do
    c = Checkin.count
    Checkin.create(:user_id=>"1", :room_id=>"1", :check_in=>"2011-07-05 22:24:00.000000", :amount_charged=>100.0)
    assert_equal c, Checkin.count
  end
  test "cannot create a new Checkin without amount" do
    c = Checkin.count
    Checkin.create(:user_id=>"1", :room_id=>"1", :check_in=>"2011-07-05 22:24:00.000000", :no_of_hrs=>5)
    assert_equal c, Checkin.count
  end
  test "can only create checkin for hours >0" do
    c = Checkin.count
    Checkin.create(:user_id=>"1", :customer_id=>@cust.id, :room_id=>"1", :check_in=>"2011-07-05 22:24:00.000000", :check_out=>"2011-07-06 17:22:00.000000", :no_of_hrs=>-5, :amount_charged=>100.0)
    assert_equal c, Checkin.count
  end


  test "no of hour should be an decimal" do
    @Checkin.no_of_hrs = "sadad2121"
    assert !@Checkin.valid?
  end
  test "Update Checkin" do
    @room= Room.create(:number =>"307D", :description => 'single bed', :charges_per_hr => 20.0, :status_id =>1)
    @check=Checkin.create(:user_id=>1, :customer_id=>@cust.id, :room_id=>@room.id, :check_in=>"2011-07-05 22:24:00.000000", :no_of_hrs=>5, :amount_charged=>100.0)

    @check.no_of_hrs = 6

    assert @check.save!
  end

  test "Delete Checkin" do
    c = Checkin.count
    @Checkin.destroy
    assert_equal c-1, Checkin.count
  end

  test "customers full name" do
    usr=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    cust=Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")
    rm= Room.create(:number=> '504', :description=>'TestRoom', :charges_per_hr=>20.0, :status_id =>"1")
    ck=Checkin.create(:user_id=> usr.id, :room_id=>rm.id, :customer_id=>cust.id, :check_in=>Time.now, :no_of_hrs=>2)
    assert_equal ck.customer_name, "maineed,sai"

  end
  test "room charges per hour" do
    usr=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    cust=Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")
    rm= Room.create(:number=> '504', :description=>'TestRoom', :charges_per_hr=>20.0, :status_id =>"1")
    ck=Checkin.create(:user_id=> usr.id, :room_id=>rm.id, :customer_id=>cust.id, :check_in=>Time.now, :no_of_hrs=>2)
    assert_equal ck.room_charges_per_hr, 20
  end







end
