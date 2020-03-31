module UsersHelper
  def show_gender(gender)
    (gender == true) ? _gender = "Male" : _gender = "Female"
  end
end
