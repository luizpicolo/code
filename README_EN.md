# C.O.D.E - Controle de ocorrências e desempenho escolar (Occurrences control and school performance.)

## About System

See the hotsite for system dissemination.: http://sistemacode.github.io/site-code/

The C.O.D.E system (Controle de Ocorrências e Desempenho Escolar - Occurrences control and school performance), It's a software developed for the purpose of controlling, in a practical and safe way, the process of occurrences and school performance reports.
It features self-explanatory menus and in the future, an electronic manual for Aiding in software handling, or, for more advanced users, the adaptation of new systems based on its source code.
Thus, it can be said that the C.O.D.E is easy to operate and automate the main routines involved in the proposed objective. Operating in web environment with clean look that makes it quick and easy navigation, working in mono or multi-user.

## Preview

![Students List](https://cdn.rawgit.com/sistemacode/code/master/public/screenshots/list_students.png)

## Installation

The C.O.D.E was developed using the Ruby programming language with the Rails Framework and PostgreSQL database. So for it to run, you need an environment that contains all of these characteristics. If you do not, follow the steps in **Creating the environment for executing the C.O.D.E**. If you already have an environment, go to **Installing C.O.D.E**

## Creating the environment for executing the C.O.D.E
***(Debian-based distributions)***
NOTE: There are several ways to create an execution environment, feel free to choose the most convenient way for you.

### First, install PostgreSQL

    sudo apt-get install postgresql postgresql-contrib

### Then, change the user's password by following the steps below

    sudo su - postgres
    psql -c "ALTER USER postgres WITH PASSWORD 'new_password'"
    sudo service postgresql restart

### Configure server Ruby

    sudo apt-get install libcurl4-openssl-dev -y &&
    curl -L get.rvm.io | bash -s stable &&
    source ~/.rvm/scripts/rvm &&
    rvm requirements &&
    rvmsudo /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion &&
    rvm install ruby &&
    rvm use ruby --default &&
    rvm rubygems current

**Only production environment**

    gem install passenger &&
    sudo apt-get install libpq-dev &&
    rvmsudo passenger-install-nginx-module &&
    sudo update-rc.d nginx defaults

## Installing C.O.D.E

**First step:** Run the following command to clone the repository for the machine that will provide the system

    git clone git@github.com:luizpicolo/code.git

**Second step:** Then run the following commands to rename the configuration files. Soon after the change data to the correct settings

    cp config/database.yml.example config/database.yml &&
    cp config/application.yml.example config/application.yml &&
    cp config/secrets.yml.example config/secrets.yml

**Third step** In the the directory where the project was cloned, run the following command to migrate the database and create the first user of the system

    bundle install && rake db:create && rake db:migrate

If you want to add some test data

    rake code:seed_example_data

## Test

To run the tests :D

    rake db:test:prepare && rspec

## TODO List

 - internationalization
 - Manual attached to the system (open to offers)

## System access

If all the steps above have been performed properly, you are able to use the system.
Access the address (if running locally `http://localhost:3000`) and use the User sown earlier.
`admin@admin.com.br` and password `12345678`
______
Created with <3 by Luiz Picolos
