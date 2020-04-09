class CancelSubscriptionService
    def initialize(subscription)
      @subscription = subscription
    end
  
    def run
      stripe_sub = Stripe::Subscription.retrieve(@subscription.stripe_subscription_id).delete
    rescue
      Rails.logger.info "Stripe subscription #{@subscription.stripe_subscription_id} not found"
    end
end
  