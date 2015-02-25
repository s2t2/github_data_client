# github_data_client

Extracts usage data from the github api (https://developer.github.com/v3/).

## Configuration

Setup the database.

```` sh
bundle exec rake db:create
bundle exec rake db:migrate
````

## Usage

Extract user and event info.

```` rb
EventExtractor.perform
````
