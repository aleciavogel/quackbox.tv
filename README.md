# Quackbox.TV

This repository was created to accompany a tutorial I wrote on my blog, called [Create a Jackbox.TV clone with Phoenix 1.4 & Docker](https://alecia.ca/blog/creating-a-clone-of-a-jackboxtv-game-with-phoenix-amp-elixir-part-1).

## Installation

Clone the repository with:
```
git clone git@github.com:aleciavogel/quackbox.tv.git
```

Copy `.env.dist` into a new file called `.env` in the root project directory. Change values as needed. If you change the names of the databases, you'll need to also update `/docker/postgres/scripts/databases.sql` before you build the "phoenix" service with Docker.

Next, run `docker-compose build` and `docker-compose up` to get everything up and running. The databases will automatically be created and migrated. Once the phoenix container finishes building, you will be able to view the site at `http://localhost:4000`.