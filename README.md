# **RepoViewer**

Repo Viewer is a microservice built to proxy client requests to [Github](https://github.com).

In this service the endpoints covered are: list github users given an id to start from, view a single user details given his username and view repos of an user given his username.

Even though these are the endpoints available for now, the application was built to make it easy to implement more proxies in it's design pattern.

## **Installation**

To use this service locally, you'll need [Elixir](https://elixir-lang.org/install.html) and
[Phoenix](https://hexdocs.pm/phoenix/installation.html).

* Install dependencies by using `mix deps.get`
* Initialize Phoenix locally by typing `mix phx.server`

*Note: If you do not wish to install it locally, just skip to the next step and paste the endpoint in the url of the live app at <https://repo-viewer.gigalixirapp.com>*

## **API**

### **Github users list**

Will list 15 items per page and return a next page link.

*Next page link is also allocated in the headers of the request, just look for `next_page` in the request headers section.*

endpoint: `/api/users?since={number}`

method: `GET`

query_param: `since` integer `optional` *The id value the list will start from*
  * When not given, `since` will have the default `0`.

**Response**
```
{
  "data": [
		{
			"avatar_url": "https://avatars.githubusercontent.com/u/19?v=4",
			"events_url": "https://api.github.com/users/brynary/events{/privacy}",
			"followers_url": "https://api.github.com/users/brynary/followers",
			"following_url": "https://api.github.com/users/brynary/following{/other_user}",
			"gists_url": "https://api.github.com/users/brynary/gists{/gist_id}",
			"gravatar_id": "",
			"html_url": "https://github.com/brynary",
			"id": 19,
			"login": "brynary",
			"node_id": "MDQ6VXNlcjE5",
			"organizations_url": "https://api.github.com/users/brynary/orgs",
			"received_events_url": "https://api.github.com/users/brynary/received_events",
			"repos_url": "https://api.github.com/users/brynary/repos",
			"site_admin": false,
			"starred_url": "https://api.github.com/users/brynary/starred{/owner}{/repo}",
			"subscriptions_url": "https://api.github.com/users/brynary/subscriptions",
			"type": "User",
			"url": "https://api.github.com/users/brynary"
		}
  ],
  "next_page": "/api/users?since=19"
}
```

### **Github user info**

Gets user info given a username

endpoint: `/api/users/:username/details`

method: `GET`

query_param: `username` string *Username of the desired user*

**Response**

```
{
	"avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
	"bio": null,
	"blog": "https://github.blog",
	"company": "@github",
	"created_at": "2011-01-25T18:44:36Z",
	"email": null,
	"events_url": "https://api.github.com/users/octocat/events{/privacy}",
	"followers": 7558,
	"followers_url": "https://api.github.com/users/octocat/followers",
	"following": 9,
	"following_url": "https://api.github.com/users/octocat/following{/other_user}",
	"gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
	"gravatar_id": "",
	"hireable": null,
	"html_url": "https://github.com/octocat",
	"id": 583231,
	"location": "San Francisco",
	"login": "octocat",
	"name": "The Octocat",
	"node_id": "MDQ6VXNlcjU4MzIzMQ==",
	"organizations_url": "https://api.github.com/users/octocat/orgs",
	"public_gists": 8,
	"public_repos": 8,
	"received_events_url": "https://api.github.com/users/octocat/received_events",
	"repos_url": "https://api.github.com/users/octocat/repos",
	"site_admin": false,
	"starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
	"subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
	"twitter_username": null,
	"type": "User",
	"updated_at": "2022-10-24T11:21:44Z",
	"url": "https://api.github.com/users/octocat"
}
```

## **Github User Repos**

Retrieves the github repositories of a given user

endpoint: `/api/users/:username/repos`

method: `GET`

query_param: `username` string *Username of the desired user*

**Response**
```
{
"data": [
		{
			"labels_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/labels{/name}",
			"keys_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/keys{/key_id}",
			"fork": true,
			"owner": {
				"avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
				"events_url": "https://api.github.com/users/octocat/events{/privacy}",
				"followers_url": "https://api.github.com/users/octocat/followers",
				"following_url": "https://api.github.com/users/octocat/following{/other_user}",
				"gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
				"gravatar_id": "",
				"html_url": "https://github.com/octocat",
				"id": 583231,
				"login": "octocat",
				"node_id": "MDQ6VXNlcjU4MzIzMQ==",
				"organizations_url": "https://api.github.com/users/octocat/orgs",
				"received_events_url": "https://api.github.com/users/octocat/received_events",
				"repos_url": "https://api.github.com/users/octocat/repos",
				"site_admin": false,
				"starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
				"subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
				"type": "User",
				"url": "https://api.github.com/users/octocat"
			},
			"hooks_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/hooks",
			"id": 132935648,
			"teams_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/teams",
			"full_name": "octocat/boysenberry-repo-1",
			"git_commits_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/git/commits{/sha}",
			"default_branch": "master",
			"downloads_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/downloads",
			"stargazers_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/stargazers",
			"blobs_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/git/blobs{/sha}",
			"collaborators_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/collaborators{/collaborator}",
			"node_id": "MDEwOlJlcG9zaXRvcnkxMzI5MzU2NDg=",
			"watchers_count": 111,
			"notifications_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/notifications{?since,all,participating}",
			"compare_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/compare/{base}...{head}",
			"trees_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/git/trees{/sha}",
			"clone_url": "https://github.com/octocat/boysenberry-repo-1.git",
			"has_downloads": true,
			"subscription_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/subscription",
			"url": "https://api.github.com/repos/octocat/boysenberry-repo-1",
			"statuses_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/statuses/{sha}",
			"milestones_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/milestones{/number}",
			"svn_url": "https://github.com/octocat/boysenberry-repo-1",
			"events_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/events",
			"updated_at": "2022-11-16T13:57:35Z",
			"created_at": "2018-05-10T17:51:29Z",
			"html_url": "https://github.com/octocat/boysenberry-repo-1",
			"archived": false,
			"allow_forking": true,
			"pulls_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/pulls{/number}",
			"mirror_url": null,
			"has_projects": true,
			"has_wiki": true,
			"topics": [],
			"language": null,
			"contributors_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/contributors",
			"web_commit_signoff_required": false,
			"issue_events_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/issues/events{/number}",
			"forks": 11,
			"merges_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/merges",
			"deployments_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/deployments",
			"visibility": "public",
			"assignees_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/assignees{/user}",
			"git_url": "git://github.com/octocat/boysenberry-repo-1.git",
			"forks_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/forks",
			"tags_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/tags",
			"open_issues": 0,
			"size": 4,
			"pushed_at": "2022-08-01T15:42:02Z",
			"issues_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/issues{/number}",
			"homepage": "",
			"private": false,
			"disabled": false,
			"forks_count": 11,
			"git_tags_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/git/tags{/sha}",
			"archive_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/{archive_format}{/ref}",
			"comments_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/comments{/number}",
			"has_pages": false,
			"issue_comment_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/issues/comments{/number}",
			"branches_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/branches{/branch}",
			"description": "Testing",
			"subscribers_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/subscribers",
			"stargazers_count": 111,
			"has_discussions": false,
			"license": null,
			"commits_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/commits{/sha}",
			"has_issues": false,
			"git_refs_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/git/refs{/sha}",
			"ssh_url": "git@github.com:octocat/boysenberry-repo-1.git",
			"releases_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/releases{/id}",
			"is_template": false,
			"name": "boysenberry-repo-1",
			"languages_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/languages",
			"open_issues_count": 0,
			"contents_url": "https://api.github.com/repos/octocat/boysenberry-repo-1/contents/{+path}",
			"watchers": 111
		}
  ]
}
```

## **Tests**

This application has 100% tests coverage. So in order to run follow the below:

* Run the tests using the command `mix test`

  or

* Check tests coverage with the command `mix coveralls`
