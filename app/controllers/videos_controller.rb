class VideosController < ApplicationController
  before_action :video_owner? , only:[:edit,:update]

  def index
    @categories = Category.all
    if params[:category_id]
      @videos=Video.includes(:categories).where(categories_videos:{category_id: params[:category_id]})
      .references(:categories).paginate(page: params[:page],per_page: 5)
    else
      @videos = Video.all.paginate(page: params[:page],per_page: 5)
    end
  end

  def new
    if(!(params[:name].nil? && params[:url].nil?))
      @name=params[:name]
      @url=params[:url]
    end
    @video=Video.new
    @categories = Category.all
  end

  def create
    @video = Video.new(video_params)
    if(category_params['categories']!=nil)
      category_params['categories'].each do |category|
        @video.categories << Category.find(category)
      end
    end
    @video.user_id=current_user.id
    if @video.save
      redirect_to current_user
    else
      @categories = Category.all
      render 'new'
    end

  end

  def edit
    @video=Video.find(params[:id])
    @categories=  Category.all
  end

  def update
    @video=Video.find(params[:id])
    @video.categories.delete_all
    if(category_params['categories']!=nil)
      category_params['categories'].each do |category|
        @video.categories << Category.find(category)
      end
    end
    if @video.update_attributes(video_params)
      redirect_to current_user
    else
      @categories=Category.all
      render 'edit'
    end
  end


  private

  def video_params
    params.require(:video).permit(:name,:url,:description)
  end

  #categories[]はcategory.idのArray
  def category_params
    params.require(:video).permit(categories: [])
  end

  def video_owner?
    video=Video.find_by(id: params[:id])
    if !video
      flash[:danger] = "This video has been removed."
      redirect_to root_url
    elsif video.user_id!=session[:user_id]
      flash[:danger] = "Please log in correct account before access this page."
      redirect_to login_url
    else

    end
  end

end
