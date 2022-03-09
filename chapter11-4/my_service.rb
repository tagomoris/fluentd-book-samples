class MyService
  def initialize(endpoint)
    @endpoint = endpoint
  end

  def send(data)
    p(here: "sending data", endpoint: @endpoint, data: data)
  end
end
