# vinaigrette

vinaigrette is a gem providing a custom `ActiveModel` object that can be used
as a serialized attribute of an `ActiveRecord` object.

## Features

- Serializable `ActiveModel` objects.
- Custom accessors with casting support default values.
- Support for Rails validations.
- Support for Rails belongs_to associations.
- Casting of ruby booleans from strings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vinaigrette'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vinaigrette

## Usage

Create a custom `Vinaigrette::Base` subclass:

```ruby
class AnethSauce < Vinaigrette::Base
end
```

Add your attributes using `vinaigrette_accessor`:

```ruby
# Simple string attribute
vinaigrette_accessor :name, String

# With a default value
vinaigrette_accessor :description, String, "Nothing here!"

# A Boolean
vinaigrette_accessor :spicy?, "Boolean", false

# With support for callables
vinaigrette_accessor :secret, String, lambda { something_secret }

# You can also create belongs_to associations
vinaigrette_accessor :sauce_id, Integer
belongs_to :sauce
```

Use `vinaigrette_serialize` method to include it in your `ActiveRecord` object:

```ruby
class SalmonDish < ActiveRecord::Base
    include Vinaigrette::Serialize

    ...

    vinaigrette_serialize :sauce, AnethSauce
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
