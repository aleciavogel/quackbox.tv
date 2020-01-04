defmodule QuackboxWeb.Admin.CategoryController do
  use QuackboxWeb, :controller

  alias Quackbox.Content
  alias Quackbox.Content.Category

  def index(conn, _params) do
    categories = Content.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Content.change_category(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    user_id = Pow.Plug.current_user(conn).id

    case Content.create_category(category_params, user_id) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: Routes.admin_category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Content.get_category!(id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Content.get_category!(id)
    changeset = Content.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Content.get_category!(id)
    user_id = Pow.Plug.current_user(conn).id

    case Content.update_category(category, category_params, user_id) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: Routes.admin_category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Content.get_category!(id)
    user_id = Pow.Plug.current_user(conn).id

    {:ok, _category} = Content.delete_category(category, user_id)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: Routes.admin_category_path(conn, :index))
  end
end
