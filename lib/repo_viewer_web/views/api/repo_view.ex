defmodule RepoViewerWeb.Api.RepoView do
  use RepoViewerWeb, :view

  def render("users_list.json", %{data: items, next_page: next_page}) do
    %{
      data: render_many(items, __MODULE__, "item.json", as: :item),
      next_page: generate_next_page(next_page)
    }
  end

  def render("user_repos.json", %{data: items}) do
    %{
      data: render_many(items, __MODULE__, "item.json", as: :item)
    }
  end

  def render("item.json", %{item: item}) do
    item
  end

  def render("error_message.json", %{message: message}) do
    %{message: message}
  end

  defp generate_next_page(next_page) do
    Routes.api_repo_path(URI.new!(""), :list_users, %{since: next_page}) <> "&per_page=15"
  end
end
