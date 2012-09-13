class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.integer :customer_id
      t.integer :room_id
      t.datetime :check_in
      t.datetime :check_out
      t.float :no_of_hrs
      t.integer :user_id
      t.float :amount_charged
      t.timestamps
    end
    Checkin.create(:customer_id=>1,
                   :room_id =>1,
                   :check_in =>Time.now+(-3).hours,
                   :no_of_hrs=>3.0,
                   :amount_charged=> 60.0,
                   :user_id=>1)
    rm=Room.find(1)
    rm.status_id=2
    rm.save!
  end

  def self.down
    drop_table :checkins
  end
end
