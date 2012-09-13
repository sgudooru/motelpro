class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.integer :failed_login_count
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :time_zone
      t.string :email
      t.string :first_name
      t.string :last_name
      t.boolean :admin, :default => 0
      t.string :perishable_token
      t.boolean :active, :default => 1
      t.string :contactno
      t.timestamps
    end

    User.create(:username=>'admin',
                :password=> 'welcome',
                :password_confirmation=> 'welcome',
                :login_count =>1,
                :last_request_at =>Time.now,
                :last_login_at =>Time.now,
                :current_login_at =>Time.now,
                :failed_login_count =>0,
                :last_login_ip =>'',
                :current_login_ip=>'',
                :time_zone =>'Central Time (US & Canada)',
                :email =>'admin@motelpro.com',
                :first_name =>'The',
                :last_name =>'Admin',
                :perishable_token =>'um7AaaMaWis2WjA3mQiK',
                :active =>1,
                :contactno =>'1010101010')
    admin = User.find(1)
    admin.admin = true
    admin.save!
    User.create(:username=>'jdoe',
                :password=> 'jdoe',
                :password_confirmation=> 'jdoe',
                :login_count =>1,
                :last_request_at =>Time.now,
                :last_login_at =>Time.now,
                :current_login_at =>Time.now,
                :failed_login_count =>0,
                :last_login_ip =>'',
                :current_login_ip=>'',
                :time_zone =>'Central Time (US & Canada)',
                :email =>'jdoe@motelpro.com',
                :first_name =>'John',
                :last_name =>'Doe',
                :perishable_token =>'um7AaaMaWis2WjA3mQiK',
                :active =>1,
               :contactno =>'1010101010')
    jdoe= User.find(2)
    jdoe.admin = false
    jdoe.save!


  end

  def self.down
    drop_table :users
  end
end
