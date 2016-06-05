require "addressable/template"
require "quokka/version"

# Tools for logging in with Facebook
module Quokka
  LOGIN_URI = Addressable::Template.new(
    "https://www.facebook.com/dialog/oauth{?q*}"
  )

  module_function

  # Constructs a url that will open a login dialog on Facebook that requests
  # permission for your app.
  #
  # @param [redirect_uri] URI which Facebook will redirect to after login.
  #
  # @return [String] URL to Facebook login dialog.
  def login_dialog_url(redirect_uri)
    LOGIN_URI.expand(
      q: {
        client_id: ENV.fetch("FACEBOOK_APP_ID"),
        redirect_uri: redirect_uri
      }
    ).to_s
  end
end
