defmodule QuackboxWeb.Admin.QuestionController do
  use QuackboxWeb, :controller

  alias Quackbox.Repo
  alias Quackbox.Content
  alias Quackbox.Content.Question

  def index(conn, _params) do
    questions = Content.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    changeset = Content.new_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    user = Pow.Plug.current_user(conn)

    case Content.create_question(question_params, user) do
      {:ok, %{:model => %Question{} = question}} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.admin_question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Content.get_question!(id)
    versions = 
      PaperTrail.get_versions(question)
      |> Repo.preload(:user)
      
    render(conn, "show.html", question: question, versions: versions)
  end

  def edit(conn, %{"id" => id}) do
    question = Content.get_question!(id)
    changeset = Content.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Content.get_question!(id)
    user = Pow.Plug.current_user(conn)

    case Content.update_question(question, question_params, user) do
      {:ok, %{:model => %Question{} = question}} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.admin_question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Content.get_question!(id)
    user = Pow.Plug.current_user(conn)

    {:ok, _question} = Content.delete_question(question, user)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.admin_question_path(conn, :index))
  end
end
