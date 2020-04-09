class ChargeService
  def initialize(payment_profile, chargeable)
    @payment_profile = payment_profile
    @chargeable = chargeable
  end

  def run
    charge = Charge.create!(payment_profile: @payment_profile, chargeable: @chargeable)
    response = create_charge(charge)
    if response[:paid]
      charge.update!(status: 'paid', external_charge_info: response)
    else
      charge.update!(status: 'failed', external_charge_info: response)
    end
    charge
  end

  private

  def create_charge(charge)
    payment_info = @payment_profile.external_payment_info
    stripe_customer_id = payment_info['stripe_customer_id'] || create_stripe_customer(payment_info['stripe_token'])

    charge_attributes = {
      amount: charge.amount,
      currency: 'usd',
      customer: stripe_customer_id,
      description: charge.description,
      metadata: { charge_id: charge.id }
    }
    begin
      Retryable.retryable(tries: 3, on: [Stripe::RateLimitError, Stripe::APIConnectionError], sleep: 1) do
        stripe_charge = Stripe::Charge.create(charge_attributes, idempotency_key: charge.unique_id)
        stripe_charge.to_hash.slice(:id, :status, :paid)
      end
    rescue Stripe::CardError => e
      body = e.json_body
      body[:error]
    rescue Stripe::StripeError => e
      Rails.logger.info "Stripe Error: #{e.inspect}"
      {}
    end
  end

  def create_stripe_customer(stripe_token)
    user_email = @payment_profile.user.email
    customer = Stripe::Customer.create(source: stripe_token, email: user_email)
    @payment_profile.update!(external_payment_info: { 'stripe_customer_id' => customer.id })
    customer.id
  end
end
