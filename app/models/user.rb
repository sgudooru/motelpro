class User < ActiveRecord::Base

  has_many :user_logs
  has_many :checkins
  validates_presence_of :first_name, :last_name
  validates_presence_of :username, :password_salt, :crypted_password, :contactno
  validates_uniqueness_of :first_name, :scope=> :last_name, :case_sensitive => false, :message =>" & Last name :user already exists"
  validates_uniqueness_of :username
  validates_format_of :first_name, :last_name, :with => /^[\sA-Za-z.]*\z/, :message => "should contain only alphabets"
  validates_presence_of :first_name, :last_name


  acts_as_authentic do |c|
    c.validates_length_of_login_field_options :in => 4..35
    c.validates_format_of_login_field_options :with => /^[A-Z0-9_]*$/i, :message => "must contain only letters, numbers, and underscores"
  end

  attr_protected :admin
  attr_accessor :date


  def full_name
    [last_name, first_name].compact.join(',')
  end

  def actual_amount_by_date(date)
    amt=0.0
    self.checkins.each do |ck|

      if (ck.check_in.strftime("%m/%d/%Y").eql?(date.strftime("%m/%d/%Y")))
        if (!ck.amount_charged.nil?)
          amt+= ck.amount_charged
        end
      end
    end
    amt
  end

  def expected_amount_by_date(date)
    amount=0.0
    self.checkins.each do |ck|
      if (ck.check_in.strftime("%m/%d/%Y").eql?(date.strftime("%m/%d/%Y")))
        amount+= ck.no_of_hrs * ck.room.charges_per_hr
      end
    end
    amount
  end

  def date_amount
    actual_amount_by_date(date)
  end

  def todays_expected_amount
    expected_amount_by_date(Time.now)
  end


end


