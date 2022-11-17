defmodule RepoViewer.Services.GithubApiTest do
  @moduledoc """
  Test module for "GithubApiTest".
  """
  alias RepoViewer.Services.GithubApi

  use ExUnit.Case, async: true

  import Tesla.Mock

  describe "success" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.github.com/users?since=10&per_page=15"} ->
          %Tesla.Env{
            status: 200,
            body: [
              %{
                "avatar_url" => "https://avatars.githubusercontent.com/u/17?v=4",
                "events_url" => "https://api.github.com/users/vanpelt/events{/privacy}",
                "followers_url" => "https://api.github.com/users/vanpelt/followers",
                "following_url" => "https://api.github.com/users/vanpelt/following{/other_user}",
                "gists_url" => "https://api.github.com/users/vanpelt/gists{/gist_id}",
                "gravatar_id" => "",
                "html_url" => "https://github.com/vanpelt",
                "id" => 17,
                "login" => "vanpelt",
                "node_id" => "MDQ6VXNlcjE3",
                "organizations_url" => "https://api.github.com/users/vanpelt/orgs",
                "received_events_url" => "https://api.github.com/users/vanpelt/received_events",
                "repos_url" => "https://api.github.com/users/vanpelt/repos",
                "site_admin" => false,
                "starred_url" => "https://api.github.com/users/vanpelt/starred{/owner}{/repo}",
                "subscriptions_url" => "https://api.github.com/users/vanpelt/subscriptions",
                "type" => "User",
                "url" => "https://api.github.com/users/vanpelt"
              }
            ]
          }
      end)

      :ok
    end

    test "perform_request/1 should return status, body and headers" do
      assert {200, _, [_body]} =
               GithubApi.perform_request("https://api.github.com/users?since=10&per_page=15")
    end
  end

  describe "fail" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.github.com/invalid"} ->
          {:error, ""}
      end)
    end

    test "perform_request/1 should return error when request invalid" do
      assert {:error, "Github api not available right now. Please try again after a few seconds."} =
               GithubApi.perform_request("invalid")
    end
  end
end
