class Category < ApplicationRecord
  has_many :campaigns, :autosave => true
end
