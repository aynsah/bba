Rails.application.routes.draw do
  resources :campaign_complaints
  resources :campaigns
  resources :products
  resources :suppliers

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#index"

  get 'monthly_product_report/:month', to: "report_products#monthly", as: 'month_product'
  get 'monthly_supplier_report/:month', to: "report_suppliers#monthly", as: 'month_supplier'
  
  get 'newsletters', to: 'newsletters#index'
  post 'newsletters/create', to: 'newsletters#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
