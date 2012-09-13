class Checkin < ActiveRecord::Base
  belongs_to :room
  belongs_to :customer
  attr_accessor :op
  validates_presence_of :check_in, :message => "enter the check in time"
  validates_presence_of :room_id, :message =>"room should be entered"
  validates_presence_of :customer_id, :message =>"customer should be entered"
  validates_presence_of :amount_charged, :greater_than=>0, :message =>"amount should be entered"
  validates_numericality_of :no_of_hrs, :greater_than=>0, :message =>"no of hours should be entered"


  def before_save
    self.check_out= check_in + self.no_of_hrs.hours
    room= self.room
    if (@op.eql?("checkin"))
      room.status_id=Status.find_by_name("Occupied").id
    elsif @op.eql?("checkout")
      room.status_id=Status.find_by_name("Dirty").id
    end
    room.save!
  end

  def room_description
    "#{self.room.number}: #{self.room.description} " unless self.room.nil?
  end

  def customer_name
    self.customer.full_name
  end

  def room_charges_per_hr
    self.room.charges_per_hr.to_f
  end

end
