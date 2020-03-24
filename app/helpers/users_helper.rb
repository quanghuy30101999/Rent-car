module UsersHelper
  def show_sex(sex)
    _sex = "Male"
    if sex == true
      "#{_sex}"
    else
      _sex = "Female"
    end
  end
end
