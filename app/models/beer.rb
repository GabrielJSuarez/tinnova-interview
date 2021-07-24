class Beer < ApplicationRecord
  belongs_to :user
  has_many :favorites
  # validates :name, uniqueness: { case_sensitive: false}
end
