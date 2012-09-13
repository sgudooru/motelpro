require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @customer = Customer.first
  end

  test "Creating a new customer" do
    c = Customer.count
    Customer.create(:first_name => "sai", :last_name => 'maineed', :contact_no => "9949501098")
    assert_equal c+1, Customer.count
  end
  test "cannot create a new customer without first name" do
    c = Customer.count
    Customer.create(:last_name => 'maineed', :contact_no => "9949501098")
    assert_equal c, Customer.count
  end
  test "cannot create a new customer without last name" do
    c = Customer.count
    Customer.create(:first_name => 'maineed', :contact_no => "9949501098")
    assert_equal c, Customer.count
  end
  test "customer already exists" do
    c = Customer.count
    Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098")
    Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098")
    assert_equal c+1, Customer.count
  end
  test "cannot create a new customer without contact no" do
    c = Customer.count
    Customer.create(:first_name => "suman", :last_name => 'gudooru')
    assert_equal c, Customer.count
  end
  test "first name should only have alphabets" do
    @customer.first_name = "sadad2121"
    assert !@customer.valid?
  end

  test "last name should only have alphabets" do
    @customer.last_name = "safsalf434"
    assert !@customer.valid?
  end
  test "Update Customer" do
    @customer.first_name = "yudhi"
    assert @customer.save!
  end

  test "Delete customer" do
    c = Customer.count
    @customer.destroy
    assert_equal c-1, Customer.count
  end

  test "full name"do
  c= Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098")
  p=c.full_name
  assert_equal p,"gudooru,suman"
  end
   test "full address"do
   c= Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098",:address=>"a", :city=>"b", :state=>"c", :zip_code=>"7")
    p=c.full_address

   end
  test "emergency contact"do
  c= Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098",:emergency_contact_name=>"sa",:emergency_contact_no=>"996623")
  p=c.emergency_contact
  end
  test "search" do
   @cust= Customer.create(:first_name => "suman", :last_name => 'gudooru', :contact_no => "9949501098")
    p=Customer.search("suman")
    assert_equal p[0].first_name,"suman"
  end

end


