require 'google/apis/youtube_v3'

def get_videos(key_word)
  youtube = Google::Apis::YoutubeV3::YouTubeService.new
  youtube.key = ENV["DEVELOPER_KEY"]
  youtube_search_list = youtube.list_searches("id,snippet", type: "video", q: key_word, max_results: 12)
end

