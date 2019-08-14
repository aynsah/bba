Rails.application.routes.draw do
  get 'campaigns/refund-donation/:order_id', to: 'campaigns#refund', as: 'refund_donation'
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
  resources :donations
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#index"
  post 'campaigns/approval/:id', to: 'campaigns#approval', as: 'approve_campaign'
  post 'campaigns/save-donation/:id', to: 'campaigns#save_donation', as: 'save_donation'
  post 'campaigns/:id', to: 'campaigns#donate', as: 'campaign_donate'
  match "notification/handle" => "campaigns#receive_webhook", via: [:post]
  get 'campaign_complaints/campaign/:id', to: "campaign_complaints#show_all", as: 'show_all_complaints'

  #MONTHLY REPORT
  get 'monthly_product_report/:month', to: "report_products#monthly", as: 'month_product'
  get 'monthly_product_report_export/:month', to: "report_products#export", as: 'month_product_export'
  get 'monthly_supplier_report/:month', to: "report_suppliers#monthly", as: 'month_supplier'

  #NEWSLETTER
  get 'newsletters', to: 'newsletters#index'
  post 'newsletters/create', to: 'newsletters#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
