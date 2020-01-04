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
end
