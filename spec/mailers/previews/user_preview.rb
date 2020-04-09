# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/reset_password_instructions
  def reset_password_instructions
    user = User.create(first_name: 'Pedro', last_name: 'Perez', email: 'heartbit_user@fake.com', password: 'password1!')
    UserMailer.reset_password_instructions(user, 'wxSeqsVvQsatcobvChq')
  end
end
