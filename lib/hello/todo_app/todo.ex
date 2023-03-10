defmodule Hello.TodoApp.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.DataContext.Comment

  schema "todos" do
    field :completed, :boolean, default: false
    field :priority, :string
    field :title, :string
    has_many :comments, Comment, foreign_key: :todo_id

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed, :priority])
    |> validate_required([:title, :completed, :priority])
  end
end
