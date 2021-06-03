class RelationshipsController < ApplicationController
  
  # def create
  #   @user = User.find(params[:follow_id])
  #   current_user.follow(@user)
  #   redirect_back(fallback_location: root_path)
  # end
    
    
  # def destroy
  #   @user = User.find(params[:follow_id])
  #   current_user.unfollow(@user)
  #   redirect_back(fallback_location: root_path)
  # end
  
  def create
    follow = current_user.follower_relationship.build(followed_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.follower_relationship.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
