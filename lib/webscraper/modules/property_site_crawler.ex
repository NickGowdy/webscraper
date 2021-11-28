defmodule PropertySiteCrawler do
  use Crawly.Spider
  @behaviour Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.rightmove.co.uk/"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://www.rightmove.co.uk/"]]

  @impl Crawly.Spider
  def parse_item(response) do
    # Parse response body to document
    {:ok, document} = Floki.parse_document(response.body)

    page_items =
      document
      |> Floki.find("a")
      |> Enum.map(fn x ->
        %{
          title: Floki.find(x, "a") |> Floki.attribute("href") |> Floki.text()
        }
      end)

    # I need to find elements from page I've gone to ^
    next_requests =
      document
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> Enum.map(fn x ->
        Crawly.Utils.build_absolute_url(x, base_url())
        |> Crawly.Utils.request_from_url()
      end)

    %{page_items: page_items, requests: next_requests}
  end
end
