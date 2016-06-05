require "spec_helper"

describe Quokka do
  let(:redirect_uri) { "http://www.example.com" }
  let(:code) { "facebook_code" }
  let(:access_token) { "access_token" }

  before do
    ENV["FACEBOOK_APP_ID"] = "app_id"
    ENV["FACEBOOK_SECRET"] = "secret"
    stub_request(:get, "https://graph.facebook.com/v2.6/oauth/access_token")
      .with(query: {
              client_id: "app_id",
              client_secret: "secret",
              code: "facebook_code",
              redirect_uri: "http://www.example.com"
            }).to_return(
              body: File.new("spec/fixtures/access_token_data.json"),
              status: 200
            )
    stub_request(:get, "https://graph.facebook.com/v2.6/me")
      .with(query: {
              access_token: "access_token"
            }).to_return(
              body: File.new("spec/fixtures/user_data.json"),
              status: 200
            )
  end

  it "has a version number" do
    expect(Quokka::VERSION).not_to be nil
  end

  describe "#login_dialog_url" do
    it "creates the login dialog url" do
      expect(described_class.login_dialog_url(redirect_uri))
        .to eq(
          "https://www.facebook.com/dialog/oauth?client_id=app_id" \
          "&redirect_uri=http%3A%2F%2Fwww.example.com"
        )
    end
  end

  describe "#access_token_data" do
    it "retrieves the access token data" do
      expect(described_class.access_token_data(redirect_uri, code))
        .to include("access_token")
    end
  end

  describe "#access_token" do
    it "retrieves the access token" do
      expect(described_class.access_token(redirect_uri, code))
        .to eq("access_token_1234")
    end
  end

  describe "#user_data" do
    it "retrieves a hash of user data" do
      expect(described_class.user_data(access_token))
        .to include("name")
    end
  end
end
