# Change the settings below to suit your needs
# All settings are initially set to their default values
FinePrint.configure do |config|
  # Engine Configuration

  # Proc called with controller as argument that returns the current user.
  # Default: lambda { |controller| controller.current_user }
  config.current_user_proc = lambda { |controller| controller.current_user }

  # Proc called with user as argument that returns true iif the user is an admin.
  # Admins can create and edit agreements and terminate accepted agreements.
  # Default: lambda { |user| false } (no admins)
  config.user_admin_proc = lambda { |user| user.is_admin? }

  # Proc called with user as argument that returns true iif the argument is a user
  # who can sign a contract.  In many systems, a non-logged-in user is represented by nil.
  # However, some systems use something like an AnonymousUser class to represent this state.
  # If this proc returns false, FinePrint will not ask for signatures and will allow access
  # to any page, so it's up to the developer to make sure that unsigned users can't access
  # pages that require a contract signature to use.
  # Default: lambda { |user| user }
  config.can_sign_contracts_proc = lambda { |user| !user.is_anonymous? }

  # Path to redirect users to when an error occurs (e.g. permission denied on admin pages).
  # Default: '/'
  config.redirect_path = '/'

  # Signature (fine_print_get_signatures) Configuration

  # Path to redirect users to when they need to agree to contract(s).
  # A list of contract names that must be agreed to will be available in the 'contracts' parameter.
  # Your code doesn't have to deal with all of them at once, e.g. you can get
  # the user to agree to the first one and then they'll just eventually be
  # redirected back to this page with the remaining contract names.
  # Default: '/'
  config.pose_contracts_path = '/terms/pose'
end

class OpenStax::Connect::ApplicationController < ActionController::Base
  helper ApplicationFooterHelper, ApplicationHelper, ApplicationTopNavHelper, OpenStax::Utilities::OsuHelper
  layout "layouts/application_body_only"
end