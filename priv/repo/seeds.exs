# Run the following command to seed your database:
#   mix run priv/repo/seeds.exs
import Ecto.Query, warn: false

alias Quackbox.Repo
alias Quackbox.Games.Game
alias Quackbox.Users
alias Quackbox.Users.User
alias Quackbox.Content.Question

game_exists = Repo.exists?(from g in Game, where: g.name == "Trivial Trivia")
questions_exist = Repo.exists?(from q in Question)
setting_admin_user = length(System.argv) == 1

# Create Trivial Trivia if it doesn't already exist
if !game_exists do
  Repo.insert!(%Game{
    name: "Trivial Trivia",
    description: "May the best lies win!"
  })
end

# Register a user and include their email as the sole argument when you
# run this seed script. This will grant the user admin privileges.
#
# Example:
#   mix run priv/repo/seeds.exs "demo@example.com"
if setting_admin_user do
  [admin_email] = System.argv
 
  Repo.get_by!(User, email: admin_email)
  |> Users.set_admin_role
end


# If the questions table is empty, seed the database with duck facts
if !questions_exist do
  question_data = [
    %{
      "prompt" => "A group of ducks is called a _____",
      "truth" => "raft",
      "lie" => "paddle",
      "category_name" => "altogether"
    },
    %{
      "prompt" => "Ducks secrete an oil which helps them to _____",
      "truth" => "stay dry",
      "lie" => "attract mates",
      "category_name" => "secretion"
    },
    %{
      "prompt" => "In 1911, Nebraskan hunters found _____ in the stomachs of ducks",
      "truth" => "gold",
      "lie" => "sand",
      "category_name" => "surprise"
    },
    %{
      "prompt" => "When ducks sleep, they sleep with _____",
      "truth" => "one eye open",
      "lie" => "a leaf in their bill",
      "category_name" => "night time"
    },
    %{
      "prompt" => "Ducks are found everywhere except _____",
      "truth" => "Antarctica",
      "lie" => "The Kerguelen Islands",
      "category_name" => "worldwide"
    },
    %{
      "prompt" => "Anatidaephoebia is the fear that somewhere, somehow, _____ is watching you",
      "truth" => "a duck",
      "lie" => "Anna Faris",
      "category_name" => "fear"
    },
    %{
      "prompt" => "The Greek words, 'platus' and 'rhynchos', translates to _____",
      "truth" => "broad bill",
      "lie" => "rhinoceros armor",
      "category_name" => "greek"
    },
    %{
      "prompt" => "You can tell the sex of duck by looking at its _____",
      "truth" => "tail",
      "lie" => "neck",
      "category_name" => "sex"
    },
    %{
      "prompt" => "Ducks moult at the end of the summer in an event known as the _____ moult",
      "truth" => "eclipse",
      "lie" => "solstice",
      "category_name" => "events"
    },
    %{
      "prompt" => "A _____ is a young female duck in her first year of egg production",
      "truth" => "pullet",
      "lie" => "hen",
      "category_name" => "lingo"
    },
    %{
      "prompt" => "Ducklings use _____ to crack out of their eggs",
      "truth" => "an egg tooth",
      "lie" => "pure determination",
      "category_name" => "birthdays"
    },
    %{
      "prompt" => "Ruddy, Mandarin, and Muscovy are _____",
      "truth" => "duck breeds",
      "lie" => "mollusks",
      "category_name" => "species"
    },
    %{
      "prompt" => "_____ is a type of sparkling wine, containing a mixture of champagne and sparkling burgundy",
      "truth" => "cold duck",
      "lie" => "sangria",
      "category_name" => "beverages"
    },
    %{
      "prompt" => "Joe Penner was a 1930's comic famous for asking, '_____'",
      "truth" => "Wanna buy a duck?",
      "lie" => "Can you hear me, mother?",
      "category_name" => "catchphrase"
    },
    %{
      "prompt" => "Swans can feed in deeper water than ducks because of their _____",
      "truth" => "longer neck",
      "lie" => "strength",
      "category_name" => "advantage"
    },
    %{
      "prompt" => "_____ is the mischievious, black Scotty dog who was curious about the ducks",
      "truth" => "Angus",
      "lie" => "Jock",
      "category_name" => "fiction"
    },
    %{
      "prompt" => "Groucho's duck gave you $100 if you could _____",
      "truth" => "say the magic word",
      "lie" => "quack in morse code",
      "category_name" => "television"
    },
    %{
      "prompt" => "_____ is the name of the mascot for the Anaheim Ducks",
      "truth" => "Wild Wing",
      "lie" => "Drake",
      "category_name" => "hockey"
    },
    %{
      "prompt" => "In the 50's, you could wear ____ to go with your white bucks",
      "truth" => "white ducks",
      "lie" => "striped slacks",
      "category_name" => "pants"
    },
    %{
      "prompt" => "The NDSCS is a club for people who collect stamps featuring _____",
      "truth" => "ducks",
      "lie" => "natural disasters",
      "category_name" => "hobbies"
    }
  ]

  Enum.each(question_data, fn(question) ->
    %Question{}
    |> Question.changeset(question)
    |> Repo.insert!()
  end)
end
