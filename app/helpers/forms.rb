helpers do

  def standardize_phone(phone)
    phone.gsub!(/(\D)/,"")
    if phone.length == 11
      phone.insert(0, '+')
    elsif phone.length == 10
      phone.insert(0, '+1') 
    end
    phone
  end

  def errors(form_fields)
    errors = []
    form_fields.map do |field, value|
      errors << "#{field.capitalize} cannot be blank" if value.blank?
    end
    errors
  end
end
