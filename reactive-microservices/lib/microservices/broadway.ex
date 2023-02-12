defmodule Pipelines.Microservices.Broadway do
  use Broadway

  alias Broadway.Message

  require Logger

  @inputs ["input"]
  @output "output"
  @concurrency 10

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: @inputs
           ]},
        concurrency: @concurrency
      ],
      processors: [default: [concurrency: @concurrency]],
      batchers: [
        default: [
          batch_size: 1000,
          batch_timeout: 1_000,
          concurrency: @concurrency
        ]
      ]
    )
  end

  @impl true
  def handle_message(:default, message, _context) do
    Message.update_data(message, &handle(&1))
  end

  @impl true
  def handle_batch(:default, messages, _batch_info, _context) do
    Logger.info("Got batch of length #{length(messages)} from position #{hd(messages).data}")

    Enum.each(messages, fn message -> batch(message.data) end)

    messages
  end

  defp handle(data) do
    String.to_integer(data)
  end

  defp batch(data) do
    :brod.produce(:kafka_client, @output, 0, _key = "", "#{data}")
  end
end
