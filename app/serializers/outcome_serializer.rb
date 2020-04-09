class OutcomeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :icon_url
  belongs_to :kit
end
