require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {create :user}

  describe "Associations" do
    it { should have_many(:posts) }
  end

  describe "Validates" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(20) }

    it { should allow_value("Long").for(:name) }
    it { should_not allow_value("Long11111111111111111111113333333333333333").for(:name) }
  end

  describe "#name_phone" do
    let(:expected_value) { "#{user.name} #{user.phone}" }

    it "should return name and phone" do
      expect(user.name_phone).to eq expected_value
    end
  end

  describe "#phone_name" do
    let(:expected_value) { "#{user.phone} #{user.name}"}

    it "should return phone and name" do
      expect(expected_value).to eq user.phone_name
    end
  end
end
