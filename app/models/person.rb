
class Person
    include MongoMapper::Document

    key :first_name, String
    key :last_name, String
    key :dob, Date
    key :sex, String
    key :has_privacy_concerns, Boolean
    key :mobile, String
    key :email, String
    key :current_contact_name, String
    key :current_contact_phone, String
    key :current_contact_email, String
    key :current_contact_description, String
    key :injury_description, String
    key :transport, String
    key :house_status, String
    key :address, String
    key :suburb, String
    key :state, String
    key :postcode, String
    key :others_at_address, String
    key :pet_details, String
    key :uuid, String
    
    before_create :create_uuid
    one :authenticable, :as => :authenticable_object
    timestamps!
 
  def name
    "#{last_name}, #{first_name}"
  end

  def accessible_for_user authenticable
    if authenticable.try(:authenticable).nil?
      true
    elsif authenticable.authenticable is_a? Person.class
      authenticable.authenticable == self
    elsif authenticable.authenticable is_a? ServiceProvider.class
      authenticable.authenticable_object.clients.include? self
    end
  end


  private
  def create_uuid
    self.uuid = SecureRandom.uuid
  end
  
end
