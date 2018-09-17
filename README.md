# Footprints

Footprints is a Rails 4.0.2 application that depends on Ruby version 2.1.5.

## System Requirements

- Ruby 2.1.5

## Installing Dependencies

**NOTE**: If your version of Ruby is not 2.1.5, and you would like to run Footprints on Mac OS, [install rbenv](https://github.com/rbenv/rbenv) to install and manage multiple versions of Ruby on your machine simultaneously. See [rbenv's documentation](https://github.com/rbenv/rbenv) for instructions on how to install and manage Ruby.

Once Ruby version 2.1.5 is installed, you'll need to manually install [bundler](https://github.com/bundler/bundler):

```bash
gem install bundler
```

Once `bundler` installs, you can use it to install Footprint's dependencies:

```bash
bundle install
```

## Required Configuration

Footprints uses several YAML files to configure its dependencies on external services like databases, etc. These YAML files must be defined for it to run in its current form.

Copy the file `config/database.yml.example` to `config/database.yml`.

Copy the file `config/mailer.yml.example` to `config/mailer.yml`.

**CAUTION**: These files may not yet contain correct configuration values. Examine and modify them to suit your environment.

## Running Footprints

To run the migrations for the applcation, run the following command:

```bash
bin/rake db:migrate RAILS_ENV=development
```

To run the built in Rails server, run the following command:

```bash
bin/rails server
```

Footprints should now be available at [http://localhost:3000](http://localhost:3000).
