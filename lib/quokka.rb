require "open-uri"
require "addressable/template"
require "quokka/version"

# Tools for logging in with Facebook
module Quokka
  GRAPH_URI = Addressable::URI.parse(
    "https://graph.facebook.com/v2.6/"
  )
  LOGIN_URI = Addressable::Template.new(
    "https://www.facebook.com/dialog/oauth{?q*}"
  )

  module_function

  # Constructs a url that will open a login dialog on Facebook that requests
  # permission for your app.
  #
  # @param redirect_uri URI which Facebook will redirect to after login
  #
  # @return [String] URL to Facebook login dialog
  def login_dialog_url(redirect_uri)
    LOGIN_URI.expand(
      q: {
        client_id: ENV.fetch("FACEBOOK_APP_ID"),
        redirect_uri: redirect_uri
      }
    ).to_s
  end

  # Gets the hash with access token data from Facebook, based on the
  # redirect_uri used in the login dialog and the code that was returned from
  # it.
  #
  # @param redirect_uri URI which Facebook redirected to after login
  # @param code The code provided by Facebook
  #
  # @return [Hash] Hash with access token data from Facebook
  def access_token_data(redirect_uri, code)
    read_json_from_url(graph_url("oauth/access_token",
                                 client_id: ENV.fetch("FACEBOOK_APP_ID"),
                                 client_secret: ENV.fetch("FACEBOOK_SECRET"),
                                 code: code,
                                 redirect_uri: redirect_uri))
  end

  def graph_url(path, query)
    uri = GRAPH_URI.join(path)
    uri.query_values = query
    uri.to_s
  end
  private_class_method :graph_url

  def read_json_from_url(url)
    JSON.parse(open(url).read)
  end
  private_class_method :read_json_from_url
end
