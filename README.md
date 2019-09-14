# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Getting Started with Docker

There are two configuration files to run the application with docker. The Dockerfile provides the base from operational system support, besides the dependencies and the rails version. It produces the copy of application folders too.


### Steps:
How it doesn't work with postgres container yet, then we have to put the database credentials at config/database.yml

create a new image called 'rails_application':
```
docker-compose run rails_application rails new .
```

Shows the informations about docker images:

```
docker images && docker ps -a
```

Beyond that it has to create our container using docker-compose file. 

```
docker-compose build -d
```

Access the aplication on: localhost:3000

to run the migrations or another command necessaries:
 ```
docker exec "cointainer-id" command
```

For example...
 ```
docker exec "cointainer-id" rake db:migrate
```


