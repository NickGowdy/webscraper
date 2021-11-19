defmodule PropertySiteCrawler do
  use Crawly.Spider
  @behaviour Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.rightmove.co.uk/"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://www.rightmove.co.uk/site-map.html"]]

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)
    # hrefs =
      document
        |> Floki.find("section")
        |> Floki.find("a")
        |> Floki.attribute("href")
        |> IO.inspect()





    # requests =
    #   Utils.build_absolute_urls(hrefs, base_url())
    #   |> Utils.requests_from_urls()

    # title = document |> Floki.find("h1.page-title-sm") |> Floki.text()

    # %{
    #   :requests => requests,
    #   :items => [%{title: title, url: response.request_url}]
    # }
  end
end
