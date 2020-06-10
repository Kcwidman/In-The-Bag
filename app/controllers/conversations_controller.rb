class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :destroy]
  before_action :all_conversations, only: [:index, :show]
  before_action :require_current_user!, only: [:show, :destroy]

  def index
  end

  def show
    @messages = @conversation.messages.order("id ASC")
    @message = Message.new
    @unread = Message.where("conversation_id = ? AND user_id != ? AND read = ?", @conversation.id, current_user.id, false)
    @unread.each do |m|
      m.update(read: true)
    end
  end

  def create
    @conversation = if Conversation.between(conversation_params[:sender_id], conversation_params[:receiver_id]).present?
      Conversation.between(conversation_params[:sender_id], conversation_params[:receiver_id]).first
    else
      Conversation.create(conversation_params)
    end
    redirect_to conversation_path(@conversation)
  end

  def destroy
    @conversation.destroy
    redirect_to action: "index"
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def all_conversations
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def conversation_params
    params.require(:conversation).permit(:sender_id, :receiver_id)
  end

  def require_current_user!
    if @conversation.sender_id != current_user.id && @conversation.receiver_id != current_user.id
      redirect_to({action: "index"}, alert: "You do not have permission to access this page!")
    end
  end
end
