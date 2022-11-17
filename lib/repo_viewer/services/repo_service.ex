defmodule RepoViewer.Services.RepoService do
  @moduledoc """
  Handles services layer for "RepoController"
  """
  alias RepoViewer.Services.GithubApi

  @per_page 15

  @doc """
  Get github users list.
  """
  def get_users(since) do
    case GithubApi.perform_request("/users?since=#{since}&per_page=#{@per_page}") do
      {status, _, body} when status >= 200 and status <= 299 ->
        {:ok, body, get_next_page(body)}

      {_, _, body} ->
        {:error, body}
    end
  end

  defp get_next_page(body) do
    List.last(body)["id"]
  end

  @doc """
  Gets github user info.
  """
  def get_user(username) do
    case GithubApi.perform_request("/users/#{username}") do
      {status, _, body} when status >= 200 and status <= 299 ->
        {:ok, body}

      {_, _, body} ->
        {:error, body}
    end
  end

  @doc """
  Gets github user repositories.
  """
  def get_user_repos(username) do
    case GithubApi.perform_request("/users/#{username}/repos") do
      {status, _, body} when status >= 200 and status <= 299 ->
        {:ok, body}

      {_, _, body} ->
        {:error, body}
    end
  end
end
