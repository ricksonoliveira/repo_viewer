defmodule RepoViewerWeb.Api.RepoControllerTest do
  @moduledoc """
  Module for "RepoControllerTest".
  """
  use RepoViewerWeb.ConnCase, async: true

  import Tesla.Mock

  describe "success" do
    setup %{conn: conn} do
      success_users_list_mock()

      {:ok, %{conn: conn}}
    end

    test "list_users/2 should return a list of github users with next page link",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :list_users), %{since: 10})

      assert response = json_response(conn, 200)
      assert response["data"] |> length() > 0
      assert response["next_page"] == "/api/users?since=17"
    end

    test "user_details/2 should return user details successfully",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :user_details, "octocat"))

      assert json_response(conn, 200)
    end

    test "user_repos/2 should return user repos successfully",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :user_repos, "octocat"))

      assert json_response(conn, 200)
    end
  end

  describe "fails" do
    setup %{conn: conn} do
      fail_users_list_mock()

      {:ok, %{conn: conn}}
    end

    test "list_users/2 should return error when invalid request",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :list_users), %{since: 10})

      assert json_response(conn, 400)
    end

    test "user_details/2 should return error when invalid request",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :user_details, "invalid"))

      assert json_response(conn, 400)
    end

    test "user_repos/2 should return error when invalid request",
         %{conn: conn} do
      conn = get(conn, Routes.api_repo_path(conn, :user_repos, "invalid"))

      assert json_response(conn, 400)
    end
  end

  defp success_users_list_mock do
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

      %{method: :get, url: "https://api.github.com/users/octocat/repos"} ->
        %Tesla.Env{
          status: 200,
          body: [
            %{
              "id" => 132_935_648,
              "node_id" => "MDEwOlJlcG9zaXRvcnkxMzI5MzU2NDg=",
              "name" => "boysenberry-repo-1",
              "full_name" => "octocat/boysenberry-repo-1",
              "private" => false,
              "owner" => %{
                "login" => "octocat",
                "id" => 583_231,
                "node_id" => "MDQ6VXNlcjU4MzIzMQ==",
                "avatar_url" => "https://avatars.githubusercontent.com/u/583231?v=4",
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
                "site_admin" => false
              }
            }
          ]
        }
    end)
  end

  defp fail_users_list_mock do
    mock(fn
      %{method: :get, url: "https://api.github.com/users?since=10&per_page=15"} ->
        %Tesla.Env{
          status: 400,
          body: "message: error"
        }

      %{method: :get, url: "https://api.github.com/users/invalid"} ->
        %Tesla.Env{
          status: 400,
          body: "message: error"
        }

      %{method: :get, url: "https://api.github.com/users/invalid/repos"} ->
        %Tesla.Env{
          status: 400,
          body: "message: error"
        }
    end)
  end
end
