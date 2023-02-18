class ChatsController < ApplicationController
    before_action :find_chat, except: [:create]
        
    def create
        message = Chat.create(permitted)
        message.broadcast
        render json: message
    end

    def delete 
        @chat.destroy
    end

    # def update 
    #     @chat.update(mess)
    # end

    private 

    def permitted 
        params.permit(:user_id,:message,:exchange_id)
    end

    def find_chat 
        @chat = chat.find(params[:exchange_id])
    end
end
