defmodule Hello.DataContextTest do
  use Hello.DataCase

  alias Hello.DataContext

  describe "comments" do
    alias Hello.DataContext.Comment

    import Hello.DataContextFixtures

    @invalid_attrs %{title: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert DataContext.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert DataContext.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Comment{} = comment} = DataContext.create_comment(valid_attrs)
      assert comment.title == "some title"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DataContext.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Comment{} = comment} = DataContext.update_comment(comment, update_attrs)
      assert comment.title == "some updated title"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = DataContext.update_comment(comment, @invalid_attrs)
      assert comment == DataContext.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = DataContext.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> DataContext.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = DataContext.change_comment(comment)
    end
  end
end
