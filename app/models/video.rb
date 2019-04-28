class Video < ApplicationRecord
  belongs_to :user,optional: true
  has_and_belongs_to_many :categories
  URL_REGEX = /\Ahttps:\/\/www\.youtube\.com\/watch\?v=(.+)\z/i
    validates :user_id, presence: true
    validates :name, presence: true, length:{maximum: 50}
    validates :url, presence: true
    validates :description, length:{maximum: 255}
    # validates :categories, presence: true

    def embed_url
        url = self.url.match(URL_REGEX)
        if !url.nil?
            "https://www.youtube.com/embed/"+url[1]
        end
    end

    def youtube_url
        self.url="https://www.youtube.com/watch?v="+self.url
    end
end
