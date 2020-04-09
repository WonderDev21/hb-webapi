class TeacherVoicepacksController < ApplicationController
  def index
    voicepacks = TeacherVoicepack.all
    render_resources(voicepacks, status: :ok)
  end
end
