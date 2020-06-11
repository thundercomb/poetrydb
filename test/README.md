# Test

## Dependencies

1. Ruby version 2.6.0
2. Ruby gem bundler
3. Docker

## Steps

1. From repo home directory bring up mongodb and poetrydb containers: `docker-compose up` 
2. From `test` directory install gems: `bundle install`
3. Run tests: `rspec spec/poetrydb_spec.rb`
