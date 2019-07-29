Rails.application.routes.draw do
  resources :payments do
    collection do
      post :receive_webhook
    end
  end
  get 'users/profil/:id', to: 'users#index', as: 'users_index'
  get '/doas/change-status/:id', to: "doas#change_status", as: 'change_status'
  resources :campaign_complaints
  resources :doas
  resources :campaigns
  resources :products
  resources :suppliers
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#index"
  get 'campaign_complaints/campaign/:id', to: "campaign_complaints#show_all", as: 'show_all_complaints'
  get 'monthly_product_report/:month', to: "report_products#monthly", as: 'month_product'
  get 'monthly_product_report_export/:month', to: "report_products#export", as: 'month_product_export'
  get 'monthly_supplier_report/:month', to: "report_suppliers#monthly", as: 'month_supplier'


  get 'newsletters', to: 'newsletters#index'
  post 'newsletters/create', to: 'newsletters#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
