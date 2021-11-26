defmodule PropertySiteCrawler do
  use Crawly.Spider
  @behaviour Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.rightmove.co.uk/"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://www.rightmove.co.uk/site-map.html"]]

  @impl Crawly.Spider
  def parse_item(response) do
    # Parse response body to document
    {:ok, document} = Floki.parse_document(response.body)

    # Create item (for pages where items exists)
    items =
      document
      |> Floki.find("main#root")
      |> Floki.find("section")
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> Enum.reject(fn x -> x == "/" || x == "#" end)
      |> Enum.filter(fn x -> String.contains?(x, "/property/") end)

    next_requests =
      items
      |> Enum.map(fn x ->
        Crawly.Utils.build_absolute_url(x, base_url())
        |> Crawly.Utils.request_from_url()
      end)

    %{items: items, requests: next_requests}
  end

  # result =
  #   reponse.body
  #   |> Floki.find("main#root")
  #   |> Floki.find("section")
  #   |> Floki.find("a")
  #   |> Floki.attribute("href")

  # result

  # |> Map.new(fn e ->
  #   IO.inspect(e, label: "ENTRY ")
  #   %{link_url: e}
  # end)

  # requests =
  #   Utils.build_absolute_urls(hrefs, base_url())
  #   |> Utils.requests_from_urls()

  # title = document |> Floki.find("h1.page-title-sm") |> Floki.text()

  # %{
  #   :requests => requests,
  #   :items => [%{title: title, url: response.request_url}]
  # }
end
