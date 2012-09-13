class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :contact_no
      t.string :state_id_card
      t.string :driving_license
      t.string :emergency_contact_name
      t.string :emergency_contact_no
      t.timestamps
    end
    Customer.create(:title=>'Mr.',
                    :first_name =>'Partha',
                    :last_name =>'Warmka',
                    :address =>'12001 Lake City Way',
                    :city =>'Seattle',
                    :state =>'Washington',
                    :zip_code =>'99101',
                    :contact_no =>'2063394576',
                    :state_id_card =>'ST00112233',
                    :driving_license =>'DL0019181',
                    :emergency_contact_name =>'Maughan Catterson',
                    :emergency_contact_no =>'8472671917')
    Customer.create(:title=>'Mr.',
                    :first_name =>'Eddie',
                    :last_name =>'Desrochers',
                    :address =>'122 South St',
                    :city =>'Waite Park',
                    :state =>'Minnesota',
                    :zip_code =>'56301',
                    :contact_no =>'6071234564',
                    :state_id_card =>'ST0891981',
                    :driving_license =>'DL0191817',
                    :emergency_contact_name =>'John Coram',
                    :emergency_contact_no =>'9917291919')
  end

  def self.down
    drop_table :customers
  end
end
