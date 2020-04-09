class UserForm < ApplicationForm
  self.main_model = :user

  attributes :first_name, :last_name, :email, :age, :city, :address, :role, :industry, :institution, :image_url, :url, :country
end
