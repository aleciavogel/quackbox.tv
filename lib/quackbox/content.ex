defmodule Quackbox.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Quackbox.Repo

  alias Quackbox.Content.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
    |> Repo.preload([:category])
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id) do 
    Repo.get!(Question, id)
    |> Repo.preload([:category])
  end

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}, user) do
    %Question{}
    |> Question.changeset(attrs)
    |> PaperTrail.insert(originator: user)
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs, user) do
    question
    |> Question.changeset(attrs)
    |> PaperTrail.update(originator: user)
  end

  @doc """
  Deletes a Question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question, user) do
    PaperTrail.delete(question, originator: user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{source: %Question{}}

  """
  def change_question(%Question{} = question) do
    preloaded = Repo.preload(question, [:category])

    question
    |> Question.changeset(%{"category_name" => preloaded.category.name})
  end

  def new_question(%Question{} = question) do
    question
    |> Question.changeset(%{})
  end

  alias Quackbox.Content.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    query = from c in Category,
      left_join: q in assoc(c, :questions),
      group_by: c.id,
      select_merge: %{question_count: count(q.id)}

    Repo.all(query)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id) do
    Repo.get!(Category, id)
    |> Repo.preload([:questions])
  end

  # Given a name, return a category
  def get_category_by_name!(name) do
    Category
    |> Repo.get_by!(name: name)
    |> Repo.preload([:questions])
  end

  def get_or_insert_category!(name) do
    downcased_name =
      name
      |> String.downcase()

    Repo.insert!(
      %Category{name: downcased_name},
      on_conflict: [set: [name: downcased_name]],
      conflict_target: :name
    )
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}, user) do
    %Category{}
    |> Category.changeset(attrs)
    |> PaperTrail.insert(originator: user)
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs, user) do
    category
    |> Category.changeset(attrs)
    |> PaperTrail.update(originator: user)
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category, user) do
    Repo.delete(category, originator: user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  # Pick 5 random categories and return an array of their names
  def pick_random_categories() do
    query =
      from c in Category,
      select: c.name,
      order_by: fragment("RANDOM()"),
      limit: 5

    Repo.all(query)
  end

  # Pick one random question, given a category
  def pick_random_category_question!(category) do
    query =
      from q in Question,
      where: q.category_id == ^category.id,
      select: [q.id, q.prompt],
      order_by: fragment("RANDOM()")
    
    Repo.one(query)
  end
end
