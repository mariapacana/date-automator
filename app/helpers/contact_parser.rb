class ContactParser

  attr_accessor :contact_list, :contacts

  def initialize(string)
    @contact_list = JSON.parse(string)["feed"]["entry"]
    @contacts = []
  end

  def streamline_contacts
    @contact_list.select! {|info| ValidateList.complete?(info) }
  end

  def make_contact_objects
    @contact_list.each do |c|
      contact = Contact.new(c)
      @contacts << contact
    end
  end

  def get_formatted_contacts
    streamline_contacts
    make_contact_objects
    @contacts
  end

end

class Contact

  attr_accessor :name, :phone, :photo, :id

  def initialize(info)
    @name = info["title"]["$t"]
    @phone = info["gd$phoneNumber"][0]["$t"]
    @id = info["id"]["$t"].gsub!("http://www.google.com/m8/feeds/contacts/maria.pacana%40gmail.com/base/", "")
    @photo = "https://www.google.com/m8/feeds/photos/media/maria.pacana@gmail.com/#{@id}?access_token=ya29.1.AADtN_WwseFDOgzSLViGNqnfFuV4AgJzkMxT79V8ANSwz4VghLDdZ4VMxIKqi4myx9Tnvg"
  end

  def to_s
    "Name: #{@name} phone: #{@phone}"
  end

end

class ValidateList

  def self.has_name?(list)
    !(list["title"]["$t"].nil?) && (list["title"]["$t"] != "")
  end

  def self.has_photo?(list)
    !(list["link"][0]["href"].nil?)
  end

  def self.has_phone?(list)
    list["gd$phoneNumber"] && !(list["gd$phoneNumber"][0]["$t"].nil?) && (list["gd$phoneNumber"][0]["$t"] != "") 
  end

  def self.complete?(list)
    self.has_name?(list) && self.has_photo?(list) && self.has_phone?(list)
  end
end