class UserSerializer < ActiveModel::Serializer
  embed :ids

  has_many :treatments, include: true
  has_many :symptoms, include: true

  attributes :id,
    :settings,
    :obfuscated_id,
    :email,
    :authentication_token,
    :locale,
    :symptom_colors,
    :treatment_colors,
    :checked_in_today,
    :settings

end