class User < ApplicationRecord

  validates :email, uniqueness: true, presence: true
  has_many :tokens #, dependent :destroy
end
