class SubscriptionsController < ApplicationController
    before_action :authenticate_user!
    respond_to :json
  
    def create
      subscription = create_or_fetch_subscription
      render_resource(subscription, status: :created)
    end

    def destroy
      subscription = current_user.subscription
      if subscription
        CancelSubscriptionService.new(subscription).run
        subscription.destroy
        render_resource(subscription, status: :ok)
      end
    end
  
    private
  
    def create_or_fetch_subscription
      return current_user.subscription if current_user.subscription
      subscription = current_user.build_subscription(subscription_params)
      subscription.amount = subscription.plan.amount
      subscription.save!
      subscription
    end
  
    def subscription_params
      restify_param(:subscription)
        .require(:subscription)
        .permit(:plan_id)
    end
end
  