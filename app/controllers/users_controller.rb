class UsersController < ApplicationController

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :name)
    end
end
