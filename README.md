# Sausage

Sausage is a gem providing a custom `ActiveModel` object that can be used
as a serialized attribute of an `ActiveRecord` object.

## Features

- Serializable ActiveModel objects.
- Custom accessors with casting support default values.
- Support for Rails validations.
- Support for Rails belongs_to associations.
- Casting of ruby booleans from strings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sausage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sausage

## Usage

Create a custom Sausage::Base subclass:

```ruby
class AnethSausage < Sausage::Base
end
```

Add your attributes using `sausage_accessor`:

```ruby
# Simple string attribute
sausage_accessor :name, string

# With a default value
sausage_accessor :description, String, "Nothing here!"

# A Boolean
sausage_accessor :spicy?, "Boolean", false

# With support for callables
sausage_accessor :secret, String, lambda { something_secret }

# You can also create belongs_to associations:
sausage_accessor :sauce_id, Integer
belongs_to :sauce
```

Use `sausage_serialize` method to include it in you `ActiveRecord` object:

```ruby
class SalmonDish < ActiveRecord::Base
    include Sausage::Serialize

    ...

    sausage_serialize :sauce, AnethSausage
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
