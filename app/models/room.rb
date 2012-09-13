class Room < ActiveRecord::Base
  has_many :checkin
  belongs_to :status
  validates_presence_of :number, :message => "room number cannot be blank"
  validates_presence_of :description, :message => "description cannot be blank"
  validates_presence_of :charges_per_hr, :message => "charge for a room should be entered"
  validates_numericality_of :charges_per_hr, :greater_than=>0
  validates_uniqueness_of :number, :case_sensitive => false

  def current_checkin
    self.checkin.last
  end

  def self.active_rooms
    Room.find(:all, :conditions => "status_id<>#{Status.find_by_name('Closed').id}")
  end
end