# Quokka

Quokka provides tools to make logging in with Facebook from your server a breeze.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quokka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quokka

## Usage

The Facebook login flow has a couple of steps that Quokka can help you out with.

First you need to setup your app id and secret by specifying them in the env variables `FACEBOOK_APP_ID` and `FACEBOOK_SECRET`.

Next your web application will need to redirect to a dialog url created by:

    Quokka.login_dialog_url(redirect_uri)

Facebook will redirect to your redirect uri with a `code` parameter. Pass this to `access_token` to get the required token.

    access_token = Quokka.access_token(redirect_uri, code)

Now you can use the `access_token` you received to get user data from Facebook.

    Quokka.user_data(access_token)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomkr/quokka. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
