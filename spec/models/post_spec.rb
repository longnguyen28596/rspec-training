require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user) { create :user }
  let(:post) { create :post, user_id: user.id }
  let(:post_1){ create :post, created_at: Date.current, user_id: user.id }
  let(:post_2){ create :post, created_at: 1.days.from_now, user_id: user.id }

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "Validates" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(10) }
  end

  describe "#created_at_desc" do
    it { expect(Post.created_at_desc).to eq [post_2, post_1] }
  end

  describe "#created_at_asc" do
    it { expect(Post.created_at_asc).to eq([post_1, post_2]) }
  end

  describe "#by_user" do
    it { expect(Post.by_user(user)).to eq([post_1, post_2]) }
  end

  describe "#title_post" do
    let(:expect_value) { "Title: #{post.title}" }

    it "Should return title post" do
      expect(expect_value).to eq post.title_post
    end
  end

  describe ".puts_content" do
    let(:expect_value) { "content" }

    it "should return text content" do
      expect(expect_value).to eq Post.puts_content
    end
  end
end
