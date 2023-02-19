class ExchangeMailer < ApplicationMailer
    default from: "alex@meetsafe.com"
    def new_exchange
        @exchange = params[:exchange]
        user = User.find(session[:user_id])
        mail(to:user.email ,subject:"Welcome to meetSafe")
    end
end
