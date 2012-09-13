class Customer < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :scope=> :last_name, :case_sensitive => false, :message =>" & Last name : customer already exists"
  validates_presence_of :contact_no
  validates_format_of :first_name, :last_name, :with => /^[\sA-Za-z.]*\z/, :message => "should contain only alphabets"

  def self.search(search_text)
    Customer.find(:all, :conditions => "driving_license like '%#{search_text}%' OR state_id_card like '%#{search_text}%' OR first_name like '%#{search_text}%' OR last_name like '%#{search_text}%' OR contact_no like '%#{search_text}%'")
  end

  def full_name
    [last_name, first_name].compact.join(',')
  end

  def full_address
    [address, city, state, zip_code].compact.join(",\n")
  end

  def emergency_contact
    [emergency_contact_name, emergency_contact_no].compact.join("\n")
  end

end
