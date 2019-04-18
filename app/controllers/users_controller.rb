class UsersController < ApplicationController

    before_action :logged_in_user? ,only:[:show,:edit,:update]
    before_action :correct_user, only:[:edit,:update]
    
      def index
        @users = User.all.paginate(page: params[:page],per_page: 10)
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
    
      private

      def logged_in_user?
        unless logged_in?
          flash[:danger] = "Please log in your account before access this page." 
          redirect_to login_url
        end
      end
    
      def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation,:image)
      end

      def correct_user
        @user=User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
      end

      def category_chart(user)
        videos=Video.where(user_id: user.id)
        data={}
        videos.each do |video|
          video.categories.each do |category|
            if data.include?(:"#{category.name}")
              data[:"#{category.name}"]+=1
            else
              data[:"#{category.name}"]=1
            end
          end
        end
        return data
      end
end
