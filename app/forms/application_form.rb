require 'set'
require 'active_support/core_ext/class/attribute'

class ApplicationForm < ActionForm::Base
  class_attribute :attributes_set, default: Set.new
  define_model_callbacks :save, only: [:before]

  class << self
    def attributes(*attrs)
      attributes = attrs.dup
      attributes.pop if attributes.last.is_a?(Hash)
      attributes_set.merge(attributes)
      super
    end

    alias attribute attributes

    def permitted_params
      attributes_set.to_a
    end
  end
end
