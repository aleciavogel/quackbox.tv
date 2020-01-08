defmodule QuackboxWeb.Admin.CategoryView do
  use QuackboxWeb, :view
  use Timex

  def time_ago_in_words(date) do
    {:ok, time_ago} = Timex.format(date, "{relative}", :relative)
    time_ago
  end
end
