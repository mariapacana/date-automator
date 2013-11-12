class ContactParser

  attr_accessor :contact_list

  def initialize(string)
    @contact_list = JSON.parse(string)["feed"]["entry"]
  end

  def print_contacts
    @contact_list.each do |c| 
      puts "#{contact = Contact.new(c)}"
    end
  end

  def streamline_contacts
    @contact_list.select! {|info| ValidateList.complete?(info) }
  end
    
end

class Contact

  attr_accessor :name, :phone, :has_photo

  def initialize(info)
    @name = info["title"]["$t"]
    @photo = info["link"][0]["href"]
    @phone = info["gd$phoneNumber"][0]["$t"]
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