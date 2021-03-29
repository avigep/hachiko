class TokensController < ApplicationController
  before_action :authorize_user_write, only: [:create, :destroy]
  before_action :set_token, only: [:destroy]

  # POST /tokens
  def create
    @token = Token.new(token_params)

    if @token.save
      render json: @token, status: :created, location: token_url(@token)
    else
      render json: @token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tokens/1
  def destroy
    @token.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.require(:token).permit(:expiration, :user_id, scopes: [])
    end
end
