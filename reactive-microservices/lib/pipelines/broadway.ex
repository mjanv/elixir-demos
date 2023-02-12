defmodule Pipelines.Broadway do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: ["input"]
           ]},
        concurrency: 8
      ],
      processors: [
        default: [
          concurrency: 8
        ]
      ],
      batchers: [
        default: [
          batch_size: 1000,
          batch_timeout: 1_000,
          concurrency: 8
        ]
      ]
    )
  end

  @impl true
  def handle_message(:default, message, _context) do
    message
    |> Message.update_data(fn data -> String.to_integer(data) end)
    |> Message.put_batcher(:default)
  end

  @impl true
  def handle_batch(:default, messages, _batch_info, _context) do
    l = length(messages)
    data = {DateTime.utc_now(), hd(messages).data, l}
    status = :brod.produce_sync(:kafka_client, "output", 0, _key = "", "length: #{l}")

    IO.inspect({data, status}, label: "Got batch")

    messages
  end
end
