FactoryBot.define do
  factory :message do
    sequence(:text) { |n| "message #{n}" }
    digest { Encryption::Digester.call(message: text) }
  end
end
