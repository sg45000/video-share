class UsersController < ApplicationController

    before_action :logged_in_user? ,only:[:show,:edit,:update]
    before_action :correct_user, only:[:edit,:update]
    
      def index
        @users = User.all.paginate(page: params[:page],per_page: 10)
        @charts = []
        @users.each do |user|
          @charts << category_chart(user)
        end
      end

      def show
        @user = User.find(params[:id])
        @chart = category_chart(@user)
        @categories = Category.all
        if params[:category_id]
          videos=Video.includes(:categories).where(categories_videos:{category_id: params[:category_id]})
          .references(:categories).paginate(page: params[:page],per_page: 5)
          @videos=videos.where(user_id: @user.id)
        else
          @videos = Video.where(user_id: @user.id).paginate(page: params[:page],per_page: 5)
        end
      end
    
      def new
        @user = User.new
      end
    
      def create
        @user = User.new(user_params)
        if @user.save
          flash[:success] = "こんにちは！#{@user.name}さん"
          log_in @user
          redirect_to @user
        else
          render 'new'
    
        end
      end
    
      def edit
        @user = User.find(params[:id])
      end
    
      def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          flash[:success] = "Account updated!"
          redirect_to user_url(@user)
        else
          render 'edit'
        end
      end

      def following
        @title = "Following"
        @user = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page],per_page: 10)
        @chart = category_chart(@user)
        render 'show_follow'
      end

      def followers
        @title = "Followers"
        @user = User.find_by(id: params[:id])
        @users = @user.followers.paginate(page: params[:page],per_page: 10)
        @chart = category_chart(@user)
        render 'show_follow'
      end
    
      private


    
      def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation,:image)
      end

      def correct_user
        @user=User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
      end

      
end
