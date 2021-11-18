class SessionsController < ApplicationController
  def new
  end

  def create
    client = Stytch::Client.new(
      env: :test,
      project_id: Rails.application.credentials.dig(:stytch, :project_id),
      secret: Rails.application.credentials.dig(:stytch, :secret),
    )
  render json: "Check your email"
  end

  def authenticate
    token = params[:token]
    stytch_token = client.magic_links.authenticate(
      token: token
    )
    # find or create the user with that ID
    @user = User.find_or_create_by!(
      stytch_user_id: stytch_token["user_id"],
    )
    sessions[:user_id] = @user.id
    redirect_to "/me"
  end

def me
  render json: current_user
end

  private

  def client
    client = Stytch::Client.new(
    env: :test,
    project_id: Rails.application.credentials.dig(:stytch, :project_id),
    secret: Rails.application.credentials.dig(:stytch, :secret),
  )
  end

end
