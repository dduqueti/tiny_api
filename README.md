# Tiny API
Fetch page contents from it's URL!

<!-- This Tiny API lets you save a page URL while fetching content from it's h1,h2,h3 and it's links elements.  Also you can displays all URL's which you have save.
 -->
[![Build Status](https://travis-ci.org/dduqueti/tiny_api.svg?branch=master)](https://travis-ci.org/dduqueti/tiny_api)

# Versions

* Ruby: 2.4.0-p0
* Rails: 4.2.7

# DEMO

You can access this application on it's heroku site: [Tiny Api!](http://tiny-api.herokuapp.com/)

To save a page create a post request to `http://tiny-app.herokuapp.com/api/v1/pages` passing an `url` as parameter.
To fetch created pages and their content, create a get request to `http://tiny-api.herokuapp.com/api/v1/pages`

# Dependencies

Tiny API uses:

* Postgres Database
* Redis (3.3.0) (install with homebrew using  `brew install redis`)

# Local Setup

Prepare the project:

1. Clone the repository.
2. `bundle install` on app directory.
3. `bundle exec rake db:create` on app directory.
4. `bundle exec rake db:migrate` on app directory.

To run test, prepare test database and execute with:

1. `bundle exec rake db:create RAILS_ENV=test` on app directory.
2. `bundle exec rake db:test:prepare` on app directory.
3. `bundle exec rake test` on app directory.

# Usage

Open a command line terminal for each of the following items and execute the instruction:

1. Start Redis server with `redis-server` (will start on to `localhost:6379` by default).
3. Start Resque background queue that will handle page parsing with `QUEUE=* rake environment resque:work`.
4. Start Rails server with on app directory `rails s` (will start on `localhost:3000` by default).

To save a page create a post request to `localhost:3000/api/v1/pages` passing an `url` as parameter.
To fetch created pages and their content, create a get request to `localhost:3000/api/v1/pages`

