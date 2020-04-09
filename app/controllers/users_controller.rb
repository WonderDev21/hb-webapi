class UsersController < ApplicationController
  def show
    render_resource(current_user)
  end

  def update
    form = form_class.new(current_user)
    form.submit(user_params)
    form.save

    render_resource(form.model)
  end

  def verify_school_code
    return render json: { school_code_verified: false }, status: :ok unless current_user.school_code
    code = params[:verification_code]
    if current_user.school_code == code
      current_user.update(school_code_verified_at: DateTime.current)
      render json: { school_code_verified: true }, status: :ok
    else
      render json: { school_code_verified: false }, status: :ok
    end
  end

  def join_school
    return render json: { data: nil }, status: '404' unless params[:school_code]
    code = params[:school_code]
    teacher = User.find_by(school_code: code)
    return render json: { data: nil }, status: '404' unless teacher
    teacher.learning_paths.find_each do |learning_path|
      UserLearningPath.create(user: current_user, learning_path: learning_path, funding_source: 'school_code')
    end
    render_resource(current_user, status: :ok)
  end

  def resend_school_code
    return unless current_user.school_code && current_user.subscription
    UserMailer.school_code_instructions(params[:email], current_user.school_code).deliver
    head :no_content
  end

  def invited_users
    invited_users = current_user.invited_users
    render_resources(invited_users, status: :ok)
  end

  def update_invitation
    invitited_user = current_user.invited_users.find_by(id: params[:data][:attributes][:invitation_id])
    invitited_user.update_columns(update_invitation_params.to_h)
    render_resource(invitited_user, status: :ok)
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    render_resource(user, status: :ok)
  end

  private

  def form_class
    @form_class ||= begin
      # case current_user.registration_state
      # when 'language_pending'
      #   LanguageForm
      # else
      UserForm
     # end
    end
  end

  def user_params
    restify_param(:user).require(:user).permit(form_class.permitted_params)
  end

  def update_invitation_params
    restify_param(:user).require(:user).permit(:first_name, :last_name, :email)
  end
end
