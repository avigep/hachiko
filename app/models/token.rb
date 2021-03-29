class Token < ApplicationRecord
  serialize :scopes, Array

  VALID_API_SCOPES = %w(weather:read users:write).freeze

  belongs_to :user

  before_validation :generate_key, :sanitize_input

  validates :key, uniqueness: true, presence: true
  validates :user, presence: true
  validate :api_scope

  private

  def generate_key
    self.key ||= SecureRandom.uuid
  end

  def sanitize_input
    self.scopes.uniq!
  end

  def api_scope
    if self.scopes.all? {|s| VALID_API_SCOPES.include?(s)}
      return
    else
      errors.add(:sopes, "Use valid api scopes from: #{VALID_API_SCOPES}")
    end
  end
end
