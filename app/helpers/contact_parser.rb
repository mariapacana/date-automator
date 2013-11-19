class ContactParser

  attr_accessor :contact_list, :contacts, :currentuser

  def initialize(currentuser)
    @contact_list = []
    @contacts = []
    @currentuser = currentuser
  end

  def get_data(request)
    parsed_url = URI.parse(request)
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(parsed_url.request_uri)
    response = http.request(request)
    response
  end

  def contact_req
    get_data("https://www.google.com/m8/feeds/contacts/#{@currentuser.email}/full?alt=json&max-results=2000&access_token=#{@currentuser.google_access_token}").body
  end

  def photo_req(contact_id)
    response = get_data("https://www.google.com/m8/feeds/photos/media/#{@currentuser.email}/#{contact_id}?access_token=#{@currentuser.google_access_token}")
    puts response.code
    if (response.code == "200")
      data_uri = Base64.encode64(response.body)
    else
      response.code
    end
  end

  def get_contacts
    info = contact_req
    @contact_list = JSON.parse(info)["feed"]["entry"]
  end

  def get_contacts_with_name_and_phone
    @contact_list.select! {|info| ValidateContact.has_name_and_phone?(info) }
  end

  def insert_contact_if_has_photo(contact)
    photo = photo_req(contact.id)
    if (photo != "404" && photo != "530") 
      contact.photo = photo
      @contacts << contact
    end
  end

  def make_contact_objects
    @contact_list.each do |c|
      contact = Contact.new(c, @currentuser)
      insert_contact_if_has_photo(contact)
    end
  end

  def get_formatted_contacts
    get_contacts
    get_contacts_with_name_and_phone
    make_contact_objects
    @contacts
  end

end

class Contact

  attr_accessor :last_name, :first_name, :phone, :photo, :id, :currentuser

  def initialize(info, currentuser)
    parse_name(info["title"]["$t"])
    @phone = info["gd$phoneNumber"][0]["$t"]
    @currentuser = currentuser
    @id = URI.decode(info["id"]["$t"]).gsub("http://www.google.com/m8/feeds/contacts/#{@currentuser.email}/base/","")
    @photo = "https://www.google.com/m8/feeds/photos/media/#{@currentuser.email}/#{@id}?access_token=#{@currentuser.google_access_token}"
  end

  def parse_name(text)
    names = text.split(" ")
    @last_name = names.last
    @first_name = names[0..-2].join(" ")
  end

  def to_s
    "Name: #{@first_name} #{@last_name} phone: #{@phone} id: #{@id}"
  end

end

class ValidateContact

  def self.has_name?(list)
    !(list["title"]["$t"].nil?) && (list["title"]["$t"] != "")
  end

  def self.has_phone?(list)
    list["gd$phoneNumber"] && !(list["gd$phoneNumber"][0]["$t"].nil?) && (list["gd$phoneNumber"][0]["$t"] != "") 
  end

  def self.has_name_and_phone?(list)
    self.has_name?(list) && self.has_phone?(list)
  end
end