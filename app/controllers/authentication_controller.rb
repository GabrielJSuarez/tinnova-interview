class AuthenticationController < ApplicationController
  def login
    render json: Auth::AuthenticationService.login(login_params)
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
