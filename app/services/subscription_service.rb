class SubscriptionService
  def initialize(subscription)
    @subscription = subscription
  end

  def run
    payment_info = @subscription.user.payment_profile.external_payment_info
    customer = find_stripe_customer(payment_info)

    begin
      Retryable.retryable(tries: 3, on: [Stripe::RateLimitError, Stripe::APIConnectionError], sleep: 1) do
        stripe_sub = customer.subscriptions.create(plan: @subscription.plan.stripe_plan_id)
        subscription_end_date = Time.zone.at(stripe_sub.current_period_end)
        @subscription.update(stripe_subscription_id: stripe_sub.id, end_date: subscription_end_date)
      end
      user = @subscription.user
      user.update(school_code: rand(100000..999999).to_s)
      UserMailer.school_code_instructions(user.email, user.school_code).deliver
    rescue Stripe::CardError, Stripe::StripeError => e
      Rails.logger.info "Stripe Error: #{e.inspect}"
    end
  end

  private

  def find_stripe_customer(payment_info)
    if  payment_info['stripe_customer_id']
      Stripe::Customer.retrieve(payment_info['stripe_customer_id'])
    else
      create_stripe_customer(payment_info['stripe_token'])
    end
  end

  def create_stripe_customer(stripe_token)
    user_email = @subscription.user.email
    customer = Stripe::Customer.create(source: stripe_token, email: user_email)
    @subscription.user.payment_profile.update!(external_payment_info: { 'stripe_customer_id' => customer.id })
    customer
  end
end
