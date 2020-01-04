defmodule Quackbox.ContentTest do
  use Quackbox.DataCase

  alias Quackbox.Content

  describe "questions" do
    alias Quackbox.Content.Question

    @valid_attrs %{lie: "some lie", prompt: "some prompt", truth: "some truth"}
    @update_attrs %{lie: "some updated lie", prompt: "some updated prompt", truth: "some updated truth"}
    @invalid_attrs %{lie: nil, prompt: nil, truth: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Content.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Content.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Content.create_question(@valid_attrs)
      assert question.lie == "some lie"
      assert question.prompt == "some prompt"
      assert question.truth == "some truth"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Content.update_question(question, @update_attrs)
      assert question.lie == "some updated lie"
      assert question.prompt == "some updated prompt"
      assert question.truth == "some updated truth"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_question(question, @invalid_attrs)
      assert question == Content.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Content.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Content.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Content.change_question(question)
    end
  end

  describe "categories" do
    alias Quackbox.Content.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Content.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Content.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Content.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Content.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_category(category, @invalid_attrs)
      assert category == Content.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Content.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Content.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Content.change_category(category)
    end
  end
end
