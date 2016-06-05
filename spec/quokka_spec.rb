require "spec_helper"

describe Quokka do
  let(:redirect_uri) { "http://www.example.com" }

  before do
    ENV["FACEBOOK_APP_ID"] = "app_id"
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
end
