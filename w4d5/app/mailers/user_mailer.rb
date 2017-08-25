class UserMailer < ApplicationMailer
    default from: 'everybody@appacademy.io'

    def welcome_email(user)
      @user = user
      @url  = 'http://99cats.com/login'
      mail(to: user.email, subject: 'Welcome to 99Cats!')
    end

end
