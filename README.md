# README

# Development

## Requirements

- Ruby 3.2.2
- Postgres server

To set up the environment, run the following commands:

```
bundle install
rails db:setup
rails s
```

## Usage

When you run the application locally, just run the import to download all the necessary data.

```
rake hotels:import
```

## Routes
There is only one endpoint `http://localhost:3000/hotels` which is able to filter by `destination`, `hotels` or both

# Details
## Merging techniques
- duplicates based on external id
- Array and Hashes are merged with unique values
- if value is empty then I update it from the next endpoint
- if value is fulfiled I don't overwrite values
Everything is covered by tests

## Technical decisions
- Ruby - I'm most familiar with this language
- Ruby on Rails - it's much faster to use framework instead of libraries, but working with libraries could have much better performance
- Postgresql - I considered SQLite as a database, but I wanted to use arrays and JSONs without any hacks so I decided to use postgres as a database
- Repository pattern - Instead of typical active record models. Every query is in one place, I return an immutable Data object instead of active record It's easier to use and easier to mock and test inside the app
- Small, encapsulated classes, which allow them for easy test coverage, easy removal or adding new providers

## Performance optimizations
- Database - with a small data set reading could be enough, but the size of endpoints could change. Database is a faster solution there.
- Indexes - there are two indexes `destination_id` and `external_id`
- Rails cache - for responses, based on filters

## Tests
- Integration test for the endpoint.
- Unit tests for the rest of the code.
- There is CI

Run tests with:
```
rspec
```

