defmodule RepoViewerWeb.Api.RepoController do
  use RepoViewerWeb, :controller

  alias RepoViewer.Services.RepoService

  def list_users(conn, %{"since" => since}) do
    case RepoService.get_users(since) do
      {:ok, users, next_page} ->
        conn
        |> put_status(:ok)
        |> put_resp_header(
          "next_page",
          Routes.api_repo_path(conn, :list_users, %{since: next_page})
        )
        |> render("users_list.json", %{data: users, next_page: next_page})

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> render("error_message.json", %{message: message})
    end
  end

  def user_details(conn, %{"username" => username}) do
    case RepoService.get_user(username) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("item.json", %{item: user})

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> render("error_message.json", %{message: message})
    end
  end

  def user_repos(conn, %{"username" => username}) do
    case RepoService.get_user_repos(username) do
      {:ok, repos} ->
        conn
        |> put_status(:ok)
        |> render("user_repos.json", %{data: repos})

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> render("error_message.json", %{message: message})
    end
  end
end
