class MessagesController < ApplicationController
  before_action :set_conversation, only: [:create]

  def create
    @message = current_user.messages.new(message_params)
    @message.conversation = @conversation
    if @message.save
    else
      flash[:errors] = @message.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @message.destroy
  end

  private
  
  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :read, :conversation_id)
  end
end
