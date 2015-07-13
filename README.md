# Write Your Own API in Rails

## Introduction

It's time to start writing your own API with Rails! You've been hired by Flatiron School to create a students API, which includes Cohort and Student objects. So exciting!

## Reviewing `respond_to`

The Rails API gives the following code as an example of web-service support:

```ruby
def index
  @people = Person.all

  respond_to do |format|
    format.html
    format.xml { render xml: @people }
  end
end
```

According to the API:

> What that says is, “if the client wants HTML in response to this action, just respond as we would have before, but if the client wants XML, return them the list of people in XML format.” (Rails determines the desired response format from the HTTP Accept header submitted by the client.)

Note that we don't actually want to use XML; we much prefer JSON. If we want to respond to the action with JSON (which we will for our API), we can write:

```ruby
respond_to do |format|
  format.json { render json: @people }
end
```

## Using the `Responders` Gem

If you want to use a controller-level `respond_to` feature, you can do so with a gem called `responders`. Simply add `gem 'responders'` to your Gemfile, and `bundle install`. Now, you can refactor your code to be less repetitive:

```ruby
class PeopleController < ApplicationController
  respond_to :json
  
  def index
    @people = Person.all
    respond_with @people
  end
end
```

## Using JBuilder

In order to customize the JSON returned from a controller-action, you can use the `jbuilder` gem.

According to the Jbuilder documentation, if you have a MessagesController, JSON from a `show` action is rendered from a partial in `app/views/message/show.json.jbuilder`. So:

```ruby
# app/views/message/show.json.jbuilder

json.(@message, :description, :created_at, :updated_at)
```

Would build:

```ruby
{
  "description": "Your description attribute",
  "created_at": "2011-10-29T20:45:28-05:00",
  "updated_at": "2011-10-29T20:45:28-05:00"
}
```

Take a look at the [Jbuilder documentation](https://github.com/rails/jbuilder) to figure out how to include a Student's corresponding Cohort in the `show` action.

## Instructions

1. Implement the API actions and get the tests to pass! You'll probably want to start by defining some routes.
2. Hints: 
  - You can [change the default response](http://stackoverflow.com/questions/10681816/render-json-instead-of-html-as-default) format in your `routes.rb` file.
  - You will want to change `protect_from_forgery with: :exception` to `protect_from_forgery with: :null_session`.
  - You can return a response with a status and an empty body with `render nothing: true, status: 200`.