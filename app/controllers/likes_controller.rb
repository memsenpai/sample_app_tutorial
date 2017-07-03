class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:liker_id]
    micropost = Micropost.find_by id: params[:post_id]
    micropost.like user
    respond_to do |format|
      format.html
      format.js{redirect_to :back}
    end
  end

  def destroy
    micropost = Like.find_by(id: params[:id]).post
    user = Like.find_by(id: params[:id]).liker
    micropost.unlike user
    respond_to do |format|
      format.html
      format.js{redirect_to :back}
    end
  end
end
