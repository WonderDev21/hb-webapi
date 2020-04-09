require 'stripe'

if Rails.env.production? && ENV['STRIPE_PRODUCTION']
  Stripe.api_key = Rails.application.credentials.stripe[:prod_secret_key]
else
  Stripe.api_key = Rails.application.credentials.stripe[:test_secret_key]
end

