class Product < ApplicationRecord
	belongs_to :supplier

	RailsAdmin.config do |config|
      config.model Product do
        export do
          field :id
          field :name
          field :price
          field :supplier
        end

        edit do
          field :name do
            required true
          end
          field :price do
            required true
          end
          field :supplier do
            required true
          end
        end
      end
    end
end
