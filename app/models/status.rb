class Status < ActiveRecord::Base
  has_many :rooms
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false


end
