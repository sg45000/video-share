module VideosHelper
    def checked?(video,category)
        video.categories.include?(category)
    end
end
