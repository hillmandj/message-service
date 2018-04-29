class Message < ApplicationRecord
  validates :text, presence: true
  validates :digest, presence: true
  validates :digest, uniqueness: { scope: :text }

  # Ensure that you can not modify the text or digest directly.
  # Doing so could result in an improper mapping.
  attr_readonly :text, :digest
end
