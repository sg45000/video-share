module UsersHelper
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
