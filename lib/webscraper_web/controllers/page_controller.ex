defmodule WebscraperWeb.PageController do
  use WebscraperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
