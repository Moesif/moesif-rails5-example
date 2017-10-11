# Moesif Rack Example with Rails

[Ruby Rack](http://rack.github.io/) is what most Ruby Web frameworks is build on top of.
[Rails](http://guides.rubyonrails.org/) is one of
the most popular frameworks.

[Moesif](https://www.moesif.com) is an API analytics platform.
[moesif-rack](https://github.com/Moesif/moesif-rack)
is a middleware that makes integration with Moesif easy for Rack based
applications and frameworks, including Rails.

This example is an Rails web application with Moesif Rack integrated. This example is based
on the [quick start tutorials of Rails](http://guides.rubyonrails.org/getting_started.html)
and this popular [blog post regarding restful APIs on Rails](https://blog.codelation.com/rails-restful-api-just-add-water/)

## Key files

moesif-rack's [github readme](https://github.com/Moesif/moesif-rack) already documented
the steps for setup. Here are some of the key files again for references:

- `Gemfile` added `gem 'moesif_rack', '~> 1.2.0'`
- `config/application.rb` where we added Moesif middleware related settings.

## How to run this example.

1. Verify Ruby and Rails versions: `$ ruby -v` should be 2.3 and above.
`$rails --version` should be 5.0 and above.

3. Install all dependencies: `$ bundle install`

4. Be sure to edit the `config/application.rb` to change the application id to your
application id obtained from Moesif.

```
moesif_options = {
  'application_id' => 'Your application Id'
}
```

6. To run: `$ bin/rails server`

7. To see a list of routes that you can run test against run `$ rake routes`, and
send some requests to some of the routes and verify that the API calls are captured in
your Moesif account.
