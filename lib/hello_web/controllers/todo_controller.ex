defmodule HelloWeb.TodoController do
  use HelloWeb, :controller

  alias Hello.TodoApp
  alias Hello.TodoApp.Todo
  alias Hello.Repo

  import Ecto.Query, only: [from: 2, from: 1]
  alias Hello.DataContext
  alias Hello.DataContext.Comment

  def index(conn, _params) do
    # todos = TodoApp.list_todos()
    query = from t in Todo, 
      left_join: c in assoc(t, :comments),
      preload: [comments: c]
    
    todos = Repo.all(query)
    render(conn, "index.html", todos: todos)
  end

  def new(conn, _params) do
    changeset = TodoApp.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case TodoApp.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # Approach 1
    # todo = TodoApp.get_todo!(id)
    # comments = Ecto.assoc(todo, :comments) |> Repo.all
    # Approach 2
    # todo = Repo.get(Todo, id) |> Repo.preload(:comments)
    # Approach 3
    todo = Repo.one(from t in Todo,
                    where: t.id == ^id, 
                    left_join: c in assoc(t, :comments),
                    preload: [comments: c])

    render(conn, "show.html", todo: todo, comments: todo.comments)
  end

  def edit(conn, %{"id" => id}) do
    todo = TodoApp.get_todo!(id)
    changeset = TodoApp.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = TodoApp.get_todo!(id)

    case TodoApp.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = TodoApp.get_todo!(id)
    {:ok, _todo} = TodoApp.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
