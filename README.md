[![Build Status](https://travis-ci.org/mongeeses/footprints-public.svg?branch=develop)](https://travis-ci.org/mongeeses/footprints-public)
# Footprints

This program is an applicant tracking tool that allows users to manage the employee hiring process from start to finish.

To run this program, first copy the repository url from github, then run
`git clone [url]` in your terminal to make a local copy of the repo.

This program uses ruby version 2.1.5.
`ruby -v` will display what version of ruby you are running.
	If you are not running the correct ruby version, run
	`rbenv install 2.1.5` to install it using homebrew, then enter
	`rbenv local 2.1.5` to switch to this ruby version.

Next, enter
`bundle install` to install all gems used in this program.
	If you do not have bundler installed, enter
	`brew install bundler` first.

Enter
`rake db:migrate` and `rake db:seed` to populate
the database with default values.

Enter
`rails server` to start the program locally.

Enter
`localhost:3000` as a url in your web browser of choice to view the program.

## Running Footprints using Docker

Using Docker to run Footprints will allow you to avoid the annoying step of
managing multiple versions of Ruby on your host OS, and will hopefully also
make it easier to run on a non-Mac environment.

1. To begin, install the latest Docker: [Install the appropriate version of Docker](https://www.docker.com/get-started) for your host OS

2. Next, configure Docker for Mac or Docker Machine 
### Docker for Mac Instructions
Once your local Docker agent is running, [use Docker Compose](https://docs.docker.com/compose/) to bring up the Rails environment:

```bash
cd /path/to/footprints-public

docker-compose up
``` 

This step should run the Rails application, **which may fail if you have not run the migrations yet**. Browse to [http://localhost:3000](http://localhost:3000) and you should see a web application running.

### Docker-Machine Instructions
Install docker-machine-nfs to use:
```bash
	brew install docker-machine-nfs
```

Set up your docker machine to run under NFS:
```bash
	docker-machine-nfs default -f --shared-folder=/[Path to footprints]/footprints-public --mount-opts="async,noatime,actimeo=1,nolock,vers=3,udp"
```

To run the rails application, find the Docker Machine ip address and use it to access the web application

```bash
	docker-machine ip
```

Visit `http://[Docker Ip address]:3000`

3. To manage gems, or run Rails, Bundler, or Rake commands, you will want to do that from inside of the running Ruby container:

```bash
cd /path/to/footprints-public

docker-compose exec ruby bash
```

4. To run the migrations, use the instructions from the previous step to open a bash session inside of the running `ruby` container, and then execute the command `bin/rake db:migrate` to run all of the migrations.

5. To bring the application back down, run `docker-compose down`

#### Note

Footprints requires anybody who logs in to also be a crafter. You will have to manually add a person to the system as a crafter in order to log into Footprints.

### Connecting to Production DB

Our production db for Footprints is only accessible from within the VPC. This means that you'll need to use an SSH tunnel through one of our production EC2 instances in order to access it. To do with this with SequelPro, configure your client in the following way:

* SSH Mode
* MySQL Host: `footprints.ce6t38dqxj5w.us-east-1.rds.amazonaws.com`
* Username: `footprints_db`
* Password: `{the password}`
* Database: `footprints_production`
* SSH Host: `ec2-18-209-172-193.compute-1.amazonaws.com`
* SSH User: `ubuntu`
* SSH Key: `{path to your footprints pem file}`

You should now be able to access the DB!

### Trello
https://trello.com/b/GuywdyDX/footprints

### Running Capistrano deploy commands

Footprints is deployed using Capistrano. Generally speaking, deploying the app
should be limited to an automated task run by our CI/CD pipeline, but there may
be scenarios where it is useful to run a deploy from your local environment.

To deploy, take the following steps:

1. Copy `.cap_env.example` to `.cap_env`

```bash
cp .cap_env.example .cap_env
```

2. Edit `.cap_env` and update the env var definitions to be correct for the deploy target (the correct values may change as we refine our provisioning scripts)

```bash
vim .cap_env
```

3. Set the environment variables from `.cap_env` in your shell

```bash
source .cap_env
```

4. Run the desired Capistrano commands

```bash
cap staging deploy
```
