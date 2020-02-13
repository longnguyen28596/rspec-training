class User < ApplicationRecord
  has_many :posts
  validates :phone, :name, presence: true
  validates :name, length: {in: 1..20} # validates_length_of :name, in: 1..20

  def name_phone
    "#{name} #{phone}"
  end

  def phone_name
    "#{phone} #{name}"
  end
end
