class Comment < ActiveRecord::Base
  belongs_to :route
  belongs_to :user
  attr_accessible :route_id, :user_grade, :user_id, :user_text
end
