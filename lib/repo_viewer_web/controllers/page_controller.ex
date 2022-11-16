defmodule RepoViewerWeb.PageController do
  use RepoViewerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
