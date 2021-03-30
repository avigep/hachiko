class User < ApplicationRecord

  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  has_many :tokens, dependent: :destroy
end
