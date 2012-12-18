# Sausage

Sausage is a gem providing a custom ActiveModel object that can be used
as a serialized attribute of an ActiveRecord object.

## Features

    - Serializable ActiveModel objects.
    - Custom accessors with casting support default values.
    - Supports Rails validations.
    - Supports Rails belongs_to associations.
    - Casting of ruby booleans from strings.

## Installation

Add this line to your application's Gemfile:

    gem 'sausage'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sausage

## Usage

TODO: Write usage instructions here

Create a custom Sausage::Model subclass:

    ...

Add your attributes using 'attr_sausage':

    ...

Use sausage_serialize method to include it in you ActiveRecord object:

    ...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
