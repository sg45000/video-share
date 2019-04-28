class YoutubeListController < ApplicationController
  require_relative '../../lib/youtube.rb'
  
  def index
    @video=Video.new
    @key_word = params[:key_word] 
    if(@key_word != nil && @key_word !="")
      videos = get_videos(@key_word).to_h
    else
      videos = get_videos("").to_h
    end
    @videos=videos[:items]
  end
  
end
