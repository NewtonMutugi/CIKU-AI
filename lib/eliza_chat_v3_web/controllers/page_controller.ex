defmodule ElizaChatV3Web.PageController do
  use ElizaChatV3Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def manifest(conn, _params) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_file(200, "priv/static/manifest.json")
  end

  def service_worker(conn, _params) do
    conn
    |> put_resp_header("content-type", "application/javascript")
    |> send_file(200, "priv/static/service-worker.js")
  end
end
