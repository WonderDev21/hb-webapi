class TeacherProgramsController < ApplicationController
  def index
    programs = TeacherProgram.all
    render_resources(programs, status: :ok)
  end
end
