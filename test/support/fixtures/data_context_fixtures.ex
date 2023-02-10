defmodule Hello.DataContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.DataContext` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Hello.DataContext.create_comment()

    comment
  end
end
