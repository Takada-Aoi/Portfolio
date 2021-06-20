class Blog < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :post_comments,dependent: :destroy
    has_many :favorites,dependent: :destroy
    attachment :image

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    has_many :tag_relationships, dependent: :destroy
     has_many :tags, through: :tag_relationships

    def save_tags(savemicropost_tags)
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        old_tags = current_tags - savemicropost_tags
        new_tags = savemicropost_tags - current_tags

        old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name: old_name)
        end

        new_tags.each do |new_name|
        micropost_tag = Tag.find_or_create_by(name: new_name)
        self.tags << micropost_tag
        end
    end

        ransacker :favorites_count do
        query = '(SELECT COUNT(favorites.blog_id) FROM favorites where favorites.blog_id = blogs.id GROUP BY favorites.blog_id)'
        Arel.sql(query)
        end

end
