require "spec_helper"

describe Quokka do
  let(:redirect_uri) { "http://www.example.com" }

  before do
    ENV["FACEBOOK_APP_ID"] = "app_id"
    ENV["FACEBOOK_SECRET"] = "secret"
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
    let(:code) { "facebook_code" }

    before do
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
    end

    it "retrieves the access token data" do
      expect(described_class.access_token_data(redirect_uri, code))
        .to include("access_token")
    end
  end
end
