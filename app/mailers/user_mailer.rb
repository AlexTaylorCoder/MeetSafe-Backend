class UserMailer < ApplicationMailer
    default from: "alex@meetsafe.com"
    def welcome_email
        @user = params[:user]
        mail(to: @user.email,subject:"Welcome to meetSafe")
    end
end
