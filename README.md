# ActiveModelJsonValidator

This gem aims to provide an easy way to validate json and jsonb attributes against a JSON schema. This gem is based on ActiveModel and [`json-schema`](https://github.com/ruby-json-schema/json-schema).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activemodel_json_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activemodel_json_validator

## Usage

Add your json validation in the model:

```ruby
class User < ApplicationRecord
  validates :preferences, json: true
end
```

By default this validation will find an schema in:
`app/models/schemas/user/preferences.json`.

```json
{
  "type": "object",
  "$schema": "http://json-schema.org/draft-04/schema",
  "required": [
    "locale",
    "currency"
  ],
  "properties": {
    "locale": { "type": "string" },
    "currency": { "type": "string" },
    "subscribed": { "type": "boolean" }
  }
}
```

Custom schema path could be passed to the validator:

```ruby
class User < ApplicationRecord
  validates :preferences, json: {
    schema: Rails.root.join('schemas', 'preferences.json').to_s
  }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alejandrodevs/activemodel_json_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActivemodelJsonValidator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alejandrodevs/activemodel_json_validator/blob/master/CODE_OF_CONDUCT.md).
