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
import Ecto.Query, warn: false

alias Quackbox.Repo
alias Quackbox.Games.Game
alias Quackbox.Users
alias Quackbox.Users.User

game_exists = Repo.exists?(from g in Game, where: g.name == "Trivial Trivia")

if !game_exists do
  Repo.insert!(%Game{
    name: "Trivial Trivia",
    description: "May the best lies win!"
  })
end

# Register a user and include their email as the sole argument when you
# run this seed script. This will grant the user admin privileges.
if length(System.argv) == 1 do
  [admin_email] = System.argv
 
  Repo.get_by!(User, email: admin_email)
  |> Users.set_admin_role
end