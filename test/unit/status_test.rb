require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  def setup
    @status = Status.first
  end

  test "Creating a new Status" do
    c = Status.count
    Status.create(:name =>"locked")
    assert_equal c+1, Status.count
  end
  test "cannot create a new Status without  name" do
    c = Status.count
    Status.create()
    assert_equal c, Status.count
  end

  test "Status already exists" do
    c = Status.count
    Status.create(:name =>"rrrr")
    Status.create(:name =>"rrrr")
    assert_equal c+1, Status.count
  end

  test "Update Status" do
    @status.name ="Repair"
    assert @status.save!
  end

  test "Delete Status" do
    c = Status.count
    @status.destroy
    assert_equal c-1, Status.count
  end

  #TODO validation for is enabled and named scope

end
