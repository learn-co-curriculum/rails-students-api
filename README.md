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

If we want to respond to the action with JSON (which we will for our API), we can write:

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

## Instructions

1. Implement the API actions and get the tests to pass! You'll probably want to start by defining some routes.
2. HINT: You will want to change `protect_from_forgery with: :exception` to `protect_from_forgery with: :null_session`.
3. HINT: You can return a response with a status and an empty body with `render nothing: true, status: 200`.