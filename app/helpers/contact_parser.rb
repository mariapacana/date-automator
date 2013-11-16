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
      puts "DATA URI BABY=============================="
      data_uri = Base64.strict_encode64(response.body)
    else
      response.code
    end
  end

  def get_contacts
    info = contact_req
    @contact_list = JSON.parse(info)["feed"]["entry"]
  end

  def streamline_contacts
    @contact_list.select! {|info| ValidateContact.complete?(info) }
  end

  def make_contact_objects
    @contact_list.each do |c|
      contact = Contact.new(c, @currentuser)
      @contacts << contact
    end
  end

  def get_formatted_contacts
    get_contacts
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
    @photo = "https://www.google.com/m8/feeds/photos/media/#{@currentuser.email}/#{@id}?access_token=#{@currentuser.google_access_token}"
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