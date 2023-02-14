import Config

config :brod,
  clients: [
    kafka_client: [
      endpoints: [localhost: 9092],
      auto_start_producers: true
    ]
  ]

config :pipelines, Pipelines.PromEx,
  disabled: false,
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: :disabled,
  metrics_server: [port: 4000]
