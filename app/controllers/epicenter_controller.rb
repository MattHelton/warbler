class EpicenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:feed, :show_user, :following, :followers]
  before_action :set_following, only: [:feed, :following, :show_user]
  before_action :set_followers, only: [:feed, :followers, :show_user]
  def feed
    @following_tweets = []

    Tweet.all.each do |tweet|
      if tweet.user_id == current_user.id || current_user.following.include?(tweet.user_id)
        @following_tweets.push(tweet)
      end
    end

    @following_tweets.sort! { |x,y| y.created_at <=> x.created_at }
  end

  def show_user
   
  end

  def now_following
    current_user.update(following: current_user.following.push(params[:id].to_i))
    
    redirect_back fallback_location: show_user_path(id: params[:id])
  end

  def unfollow
    list = current_user.following
    list.delete(params[:id].to_i)
    current_user.update(following: list)

    redirect_back fallback_location: show_user_path(id: params[:id])
  end
  
  def tag_tweets
    @tag = Tag.find(params[:id])
    @tweets = @tag.tweets
  end

  def all_users
    @users = User.all
  end

  def following 
    
  end

  def followers
   
  end 

  private

  def set_user
   @user = action_name == 'feed' ? current_user : User.find(params[:id])
  end

  def set_following
    @following = User.where(id: @user.following)
  end

  def set_followers
    @followers = []

    User.all.each do |u|
      @followers.push(u) if u.following.include?(@user.id)
    end
  end
  
end
