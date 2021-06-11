class Relationship < ApplicationRecord
  #following,followerモデルを擬似的に作成
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"
end
