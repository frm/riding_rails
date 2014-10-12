class MicropostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to user_profile_path(current_user)
    else
      flash[:notice] = "Something is wrong!"
      render :new
    end
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "Micropost deleted"
    redirect_to user_profile_path(current_user)
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
