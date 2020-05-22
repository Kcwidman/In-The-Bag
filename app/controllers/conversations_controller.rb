class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  def index
    @conversations = current_user.conversations
  end

  def show
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).present?
    else
      @conversation = Conversation.new(conversation_params)
    end
  end

  def destroy
    @conversation.destroy
    redirect_to action: "index"
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:sender_id, :receiver_id)
  end

end
