class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 10

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.order(created_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.read = []
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: t('.success') }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:content)
  end

end
