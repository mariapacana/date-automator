class ContactParser

  attr_accessor :contact_list, :contacts, :currentuser

  def initialize(currentuser)
    @contact_list = []
    @contacts = []
    @currentuser = currentuser
  end

  def contact_req
    "https://www.google.com/m8/feeds/contacts/#{@currentuser.email}/full?alt=json&max-results=2000&access_token=#{@currentuser.google_access_token}"
  end

  def get_photo_req(contact_id)
    "https://www.google.com/m8/feeds/photos/media/#{@currentuser.email}/#{contact_id}?access_token=#{@currentuser.google_access_token}"
  end

  def get_contacts(info)
    @contact_list = JSON.parse(info)["feed"]["entry"]
  end

  def streamline_contacts
    @contact_list.select! {|info| ValidateContact.complete?(info) }
  end

  def make_contact_objects
    @contact_list.each do |c|
      contact = Contact.new(c, @currentuser)
      contact.photo = self.get_photo_req(contact.id)
      # sleep(0.1)
      @contacts << contact
    end
  end

  def get_formatted_contacts(info)
    get_contacts(info)
    streamline_contacts
    make_contact_objects
    @contacts
  end

end

class Contact

  attr_accessor :name, :phone, :photo, :id, :currentuser

  def initialize(info, currentuser)
    @name = info["title"]["$t"]
    @phone = info["gd$phoneNumber"][0]["$t"]
    @currentuser = currentuser
    @id = URI.decode(info["id"]["$t"]).gsub("http://www.google.com/m8/feeds/contacts/#{@currentuser.email}/base/","")
  end

  def to_s
    "Name: #{@name} phone: #{@phone} id: #{@id}"
  end

end

class ValidateContact

  def self.has_name?(list)
    !(list["title"]["$t"].nil?) && (list["title"]["$t"] != "")
  end

  def self.has_phone?(list)
    list["gd$phoneNumber"] && !(list["gd$phoneNumber"][0]["$t"].nil?) && (list["gd$phoneNumber"][0]["$t"] != "") 
  end

  def self.complete?(list)
    self.has_name?(list) && self.has_phone?(list)
  end
end