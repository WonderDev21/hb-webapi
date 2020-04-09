class Subscription < ApplicationRecord
    belongs_to :user
    belongs_to :plan
    has_many :charges, as: :chargeable

    after_create :create_stripe_subscription

    def create_stripe_subscription
      SubscriptionService.new(self).run
    end
end
