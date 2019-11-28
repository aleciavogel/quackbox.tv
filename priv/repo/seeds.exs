# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quackbox.Repo.insert!(%Quackbox.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Quackbox.Repo
alias Quackbox.Games.Game

Repo.insert!(%Game{
  name: "Trivial Trivia",
  description: "May the best lies win!"
})