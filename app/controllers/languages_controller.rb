class LanguagesController < ApplicationController
  def index
    languages = Language.all
    render_resources(languages, status: :ok)
  end
end
