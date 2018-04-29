class Message < ApplicationRecord
  validates :text, presence: true
  validates :digest, presence: true
  validates :digest, uniqueness: { scope: :text }
end
