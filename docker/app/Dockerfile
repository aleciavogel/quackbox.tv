FROM elixir:1.9

RUN apt-get update
RUN apt-get install --yes postgresql-client
RUN apt-get install make gcc libc-dev

# install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# install the latest version of Phoenix
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# install NodeJS and NPM
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs
RUN apt-get install -y inotify-tools

# copy our code into a new directory named 'app' it and set it as our working directory
COPY . /app
WORKDIR /app

# Convert entrypoint.sh to an executable file
# (Note: this file will run every time the container starts up)
COPY ./docker/app/entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]