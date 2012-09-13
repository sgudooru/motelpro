class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name
      t.timestamps
    end

    Status.create(:name=>'Ready')
    Status.create(:name=>'Occupied')
    Status.create(:name=>'Dirty')
    Status.create(:name=>'Closed')

  end
  def self.down
    drop_table :statuses
  end
end
