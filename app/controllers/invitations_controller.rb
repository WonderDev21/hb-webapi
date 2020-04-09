class InvitationsController < Devise::InvitationsController
  def resource_name
    :user
  end

  def update
    super do
      if resource.persisted? && resource.invitation_accepted_at
        return render_resource(resource, status: :created)
        # bridge table entry
      else
        return render_resource(nil, status: :unprocessable_entity)
      end
    end
  end
end
