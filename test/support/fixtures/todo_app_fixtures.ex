defmodule Hello.TodoAppFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.TodoApp` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        completed: true,
        priority: "some priority",
        title: "some title"
      })
      |> Hello.TodoApp.create_todo()

    todo
  end
end
