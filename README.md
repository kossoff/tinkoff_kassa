# TinkoffKassa

This is a Ruby wrapper for Tinkoff Kassa API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinkoff_kassa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tinkoff_kassa

## Usage

Configure the gem with the credentials provided by the bank. If you are using Ruby on Rails, you should do that in an initializer.

```ruby
# config/initializers/tinkoff_kassa.rb
TinkoffKassa.configure do |config|
  config.terminal_key = ENV.fetch('TINKOFF_TERMINAL_KEY')
  config.password     = ENV.fetch('TINKOFF_PASSWORD')
end
```

Use the client to work with payments.

```ruby
# Parameters: amount (in kopecks), order_id, data, options (hash, optional)
# data — a hash of arbitrary data (up to 20 pairs), "Email" key is required
# More info: https://www.tinkoff.ru/kassa/develop/api/payments/init-description/
TinkoffKassa::Client.init(100, 1, { Email: 'foo@bar.com' })

# Parameters: payment_id, options (hash, optional)
TinkoffKassa::Client.confirm(1)

# Parameters: payment_id, rebill_id, options (hash, optional)
TinkoffKassa::Client.charge(1, 2)

# Parameters: payment_id, options (hash, optional)
TinkoffKassa::Client.cancel(1)

# Parameters: payment_id, options (hash, optional)
TinkoffKassa::Client.state(1)
```

You can view all available options in the [official documentation](https://www.tinkoff.ru/kassa/dev/payments/).

A notification will be sent to if you provided the URL. You should use it to update the status of your payment / order.

```ruby
notification = Tinkoff::Notification.new(params)
order = Order.find(notification.order_id)
order.update_attribute(:paid, true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
