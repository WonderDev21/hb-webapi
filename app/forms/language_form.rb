class LanguageForm < ApplicationForm
  self.main_model = :user

  attribute :language_id

  validates_inclusion_of :language_id, in: ->(_) { Language.pluck(:id) }

  before_save :select_language

  def select_language
    model.select_language
  end
end
