RailsAdmin.config do |config|
  config.compact_show_view = false
  ### Popular gems integration
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin == true
  end
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.navigation_static_links = {
    'Google' => 'http://www.google.com',
    'Home' => 'http://ddbe5d69.ngrok.io'
  }
  config.navigation_static_label = "Custom Links"

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.excluded_models << "ReportDonation"
  config.excluded_models << "ReportProduct"
  config.excluded_models << "ReportSupplier"
  config.excluded_models << "Ckeditor::Asset"
  config.excluded_models << "Ckeditor::Picture"
  config.excluded_models << "Ckeditor::AttachmentFile"

end
