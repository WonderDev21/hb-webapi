class ErrorSerializer
  def initialize(model)
    @model = model
  end

  def serializable_hash
    errors = @model.errors.messages.map do |field, model_errors|
      model_errors.map do |error_message|
        {
          source: { pointer: "/data/attributes/#{field}" },
          detail: error_message
        }
      end
    end

    @model.class.reflect_on_all_associations.each do |relation|
      errors << relation_errors(relation)
    end
    { errors: errors.flatten }
  end

  alias to_hash serializable_hash

  private

  def relation_errors(relation)
    errors = []
    Array(@model.send(relation.name)).each_with_index do |child, index|
      errors << child.errors.messages.map do |field, child_errors|
        child_errors.map do |error_message|
          {
            source: { pointer: "/data/attributes/#{child.model_name.plural}[#{index}].#{field}" },
            detail: error_message
          }
        end
      end
    end
    errors
  end
end
