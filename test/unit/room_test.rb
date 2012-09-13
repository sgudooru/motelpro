require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.first
  end

  test "Creating a new room" do
    c = Room.count
    Room.create(:number =>"302", :description => 'single bed', :charges_per_hr => "20",:status_id =>"1")
    assert_equal c+1, Room.count
  end
  test "cannot create a new Room without first name" do
    c = Room.count
    Room.create(:description => 'double bed', :charges_per_hr => "50",:status_id =>"1")
    assert_equal c, Room.count
  end
  test "cannot create a new Room without Description" do
    c = Room.count
    Room.create(:number =>"309", :charges_per_hr => "50",:status_id =>"1")
    assert_equal c, Room.count
  end
  test "Room already exists" do
    c = Room.count
    Room.create(:number =>"304", :description => 'double bed', :charges_per_hr => "50",:status_id =>"1")
    Room.create(:number =>"304", :description => 'single bed', :charges_per_hr => "50",:status_id =>"1")
    assert_equal c+1, Room.count
  end
  test "cannot create a new Room without charges per hour" do
    c = Room.count
    Room.create(:number =>"304", :description => 'double bed',:status_id =>"1")
    assert_equal c, Room.count
  end

  test "charges per hour should be integer" do
     rm= Room.create(:number =>"304", :description => 'double bed', :charges_per_hr => "50")
    rm.charges_per_hr = "sadad2121"
    assert !rm.valid?
  end
  test "Update Room" do

     rm= Room.create(:number =>"34", :description => 'double bed', :charges_per_hr => "50")
    rm.number = "306"
    assert rm.save
  end

  test "Delete Room" do

   rm= Room.create(:number =>"304", :description => 'double bed', :charges_per_hr => "50")
   c = Room.count
    rm.destroy
    assert_equal c-1, Room.count
  end

  test "checkin created for room" do
    usr=User.create(:username=>"demo", :password=>"demo", :password_confirmation=>"demo", :admin=>"f", :first_name=>"suman", :last_name=>"g", :contactno=>"9949566523", :email=>"sa@gmail.com")
    cust=Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")

    strdy=Status.find_by_name("Ready")
    stoc=Status.find_by_name("Occupied")

    if (strdy.nil?)
      strdy=Status.create(:name=> "Ready")
    end
    if (stoc.nil?)
      stoc=Status.create(:name=> "Occupied")
    end
    rm= Room.create(:number=> '504', :description=>'TestRoom', :charges_per_hr=>20.0, :status_id=> strdy.id)
    ck=Checkin.create(:user_id=> usr.id, :room_id=>rm.id, :customer_id=>cust.id, :check_in=>Time.now, :no_of_hrs=>2)
    assert_equal rm.id, ck.room_id
    ck.destroy
    rm.destroy
    cust.destroy
    usr.destroy
  end

  test "active rooms test" do
    Room.find(:all, :conditions => "status_id<>#{Status.find_by_name('Closed').id}")
    c = Room.active_rooms.count
    closed =Status.find_by_name("Closed")
    if (closed.nil?)
      closed=Status.create(:name=> "Closed")
    end
    Room.create(:number =>"504D", :description => 'double bed', :status_id=>closed.id)
    assert_equal c, Room.active_rooms.count
  end
end
