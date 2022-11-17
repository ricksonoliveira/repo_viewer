defmodule RepoViewer.Services.GithubApi do
  @moduledoc """
  Handles Github API calls
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  @doc """
  Performs github api call to given endpoint.
  """
  def perform_request(url) do
    with {:ok, response} <- get(url),
         status <- response.status,
         headers <- response.headers,
         body <- response.body do
      {status, headers, body}
    else
      {:error, _} ->
        {:error, "Github api not available right now. Please try again after a few seconds."}
    end
  end
end
