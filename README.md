# LiveResource

A number of extremely good frameworks exist in Ruby for creating request/response applications, such as Rails,
Sinatra etc.

Requesting resources (for example, /profiles.json) is handled very well. In Rails the request would route through the
ProfilesController, load the collection of Profile models, and render the index view (MVC). Other framweorks supply
similar abstractions.

Unfortunately, frameworks based on the request/response model of interaction don't have an appropriate abstraction
for things that change between requests. For example, when a Profile is created the /profiles.json resource has
changed, but in the absence of a request there's no way for my application to notify clients that the resource has
changed.

The LiveResource gem adds the concept of a Resource, which is an object derived from server state (such as models) that
can be *pulled* (requested, as in the above example), or *pushed* when changes to server state are detected.

It also provides a Builder object that can be used to fluently describe the attributes of a live resource; namely:
its dependencies on elements of server state and the method of identifying individual instances of the resource.

## Example

Describe the `profiles#show` resource.

```ruby
profiles_show_resource = LiveResource::Builder.new(:profiles_show, ...)

# How do we identify individual `profile_show_resource`s?
# This allows us to describe changes to a particular instance of the resource.
profiles_show_resource.identifier { |profile| "/profiles/#{profile.id}" }

# If a Profile changes, there will be a corresponding `profiles_show_resource` instance that changes.
# In other words, when a Profile changes, push an update to the `profiles_show_resource` identified by the calling the
# `#identifier` block we just defined and passing in the modified `profile` instance.
profiles_show_resource.depends_on(Profile) { |profile| push(profile) }
```

## Integrations

* [Rails](http://github.com/live-resource/rails)
** Allows you to define live resources inline in controllers
** Hooks into Rails' configuration
* [ActiveRecord](http://github.com/live-resource/rails)
** Adds support for specifying dependencies on ActiveRecord model classes
* [Pubnub](http://github.com/live-resource/pubnub)
** Adds support for pushing updates via Pubnub
* [RSpec](http://github.com/live-resource/rspec)
** Adds support for testing live resources in RSpec

## Installation

Add this line to your application's Gemfile:

    gem 'live_resource'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install live_resource

You will probably need one or more of the above integrations as well.

    gem 'live_resource-rails'        # For Rails projects
    gem 'live_resource-activerecord' # If you're using AR
    gem 'live_resource-pubnub'       # To push updates through Pubnub

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
