# Localstack Kinesis Demo

2 simple scripts to demonstrate how [localstack](https://github.com/localstack/localstack) can be used, instead of AWS, in development.

## Interactions With (Local) AWS

1.  [producer.rb](./producer.rb) produces messages
2.  [consumer.rb](./consumer.rb) consumes those messages

## Installing

### Installing (on system)

#### Get Localstack Running

1.  `docker-compose up` (from the root of this application)

(Note that on MacOS you may have to run `TMPDIR=/private$TMPDIR docker-compose up` if `$TMPDIR` contains a symbolic link that cannot be mounted by Docker.)

#### Install this Application

`bundle install`

### Installing (Docker)

_TODO_

## Running

1.  Make sure [local stack is running](#get-localstack-running).
2.  `ruby ./producer.rb && ruby ./consumer.rb`
