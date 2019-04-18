class User < ApplicationRecord
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
    has_many :following, through: :active_relationships,source: :followed
    has_many :followers, through: :passive_relationships,source: :follower
    has_many :videos
    mount_uploader :image, ImagesUploader
    validates :name , presence: true, length: {minimum: 6, maximum: 20}
    EMAIL_REGEX = /\A[\w\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: true
    validates :password, presence: true, length: {minimum: 6, maximum: 16}
    attr_accessor :remenber_token
    has_secure_password

    def remenber
        self.remenber_token = User.new_token
        self.update_attribute(:remenber_digest, User.digest(remenber_token))
    end

    def forget
        self.update_attribute(:remenber_digest, nil)
    end

    def authenticated?(remenber_token)
        return false if remenber_digest.nil?  
        BCrypt::Password.new(remenber_digest) == remenber_token

    end

    def follow(other_user)
        following << other_user
    end

    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end

    def following?(other_user)
        following.include?(other_user)
    end

    class<<self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token 
            SecureRandom.urlsafe_base64
        end

    end
end
