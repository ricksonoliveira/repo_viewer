defmodule RepoViewer.Services.RepoServiceTest do
  @moduledoc """
  Test module for "RepoServiceTest".
  """
  use ExUnit.Case, async: true

  alias RepoViewer.Services.RepoService

  import Tesla.Mock

  describe "success" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.github.com/users?since=0&per_page=15"} ->
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

        %{method: :get, url: "https://api.github.com/users/octocat"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "login" => "octocat",
              "id" => 1,
              "node_id" => "MDQ6VXNlcjE=",
              "avatar_url" => "https://github.com/images/error/octocat_happy.gif",
              "gravatar_id" => "",
              "url" => "https://api.github.com/users/octocat",
              "html_url" => "https://github.com/octocat",
              "followers_url" => "https://api.github.com/users/octocat/followers",
              "following_url" => "https://api.github.com/users/octocat/following{/other_user}",
              "gists_url" => "https://api.github.com/users/octocat/gists{/gist_id}",
              "starred_url" => "https://api.github.com/users/octocat/starred{/owner}{/repo}",
              "subscriptions_url" => "https://api.github.com/users/octocat/subscriptions",
              "organizations_url" => "https://api.github.com/users/octocat/orgs",
              "repos_url" => "https://api.github.com/users/octocat/repos",
              "events_url" => "https://api.github.com/users/octocat/events{/privacy}",
              "received_events_url" => "https://api.github.com/users/octocat/received_events",
              "type" => "User",
              "site_admin" => false,
              "name" => "monalisa octocat",
              "company" => "GitHub",
              "blog" => "https://github.com/blog",
              "location" => "San Francisco",
              "email" => "octocat@github.com",
              "hireable" => false,
              "bio" => "There once was...",
              "twitter_username" => "monatheoctocat",
              "public_repos" => 2,
              "public_gists" => 1,
              "followers" => 20,
              "following" => 0,
              "created_at" => "2008-01-14T04:33:35Z",
              "updated_at" => "2008-01-14T04:33:35Z"
            }
          }
      end)

      :ok
    end

    test "get_users/1 should return users list successfully" do
      assert {:ok, _, 17} = RepoService.get_users(0)
    end

    test "get_user/1 should return users details successfully" do
      assert {:ok, _} = RepoService.get_user("octocat")
    end

    test "get_user/1 should return users repos successfully" do
      assert {:ok, _} = RepoService.get_user("octocat")
    end
  end

  describe "fail" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.github.com/users?since=0&per_page=15"} ->
          %Tesla.Env{
            status: 400,
            body: "message: error"
          }

        %{method: :get, url: "https://api.github.com/users/octocat"} ->
          %Tesla.Env{
            status: 400,
            body: "message: error"
          }

        %{method: :get, url: "https://api.github.com/users/octocat/repos"} ->
          %Tesla.Env{
            status: 400,
            body: "message: error"
          }
      end)

      :ok
    end

    test "get_users/1 should return error when invalid" do
      assert {:error, "message: error"} = RepoService.get_users(0)
    end

    test "get_user/1 should return error when invalid" do
      assert {:error, "message: error"} = RepoService.get_user("octocat")
    end

    test "get_user_repos/1 should return error when invalid" do
      assert {:error, "message: error"} = RepoService.get_user_repos("octocat")
    end
  end
end
