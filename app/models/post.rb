class Post < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true
  validates :content, length: { minimum: 10 }

  scope :created_at_desc, -> { order created_at: :desc }
  scope :created_at_asc, -> { order created_at: :asc }
  scope :by_user, -> (user_id){ where user_id: user_id }

  def title_post
    "Title: #{title}"
  end

  class << self
    def puts_content
      "content"
    end
  end
end
