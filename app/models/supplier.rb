class Supplier < ApplicationRecord
	has_many :products, :dependent => :delete_all

	RailsAdmin.config do |config|
      config.model Supplier do

        export do
          field :id
          field :name
          field :country
        end

        edit do
          field :name do
            required true
          end
          field :country do
            required true
          end
          field :products
        end
      end
    end
end
