class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :number
      t.string :description
      t.integer :charges_per_hr
      t.integer :key_no
      t.integer :status_id
      t.timestamps

    end
    Room.create(:number=>'102S',
                :description => 'Single Bed Room',
                :charges_per_hr=> 20.0,
                :key_no => '991',
                :status_id=>1)
    Room.create(:number=>'205D',
                :description => 'Double Bed Room',
                :charges_per_hr=> 45.0,
                :key_no => '567',
                :status_id=>1)
    Room.create(:number=>'301S',
                :description => 'Sinlge Bed Room with TV',
                :charges_per_hr=> 25.0,
                :key_no => '431',
                :status_id=>1)

    Room.create(:number=>'404S',
                :description => 'Double Bed Room with TV',
                :charges_per_hr=> 50.0,
                :key_no => '522',
                :status_id=>3)
  end

  def self.down
    drop_table :rooms
  end
end
