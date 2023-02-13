import Config

Application.start(:nerves_bootstrap)

config :hello_nerves, target: Mix.target()


config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

config :nerves, source_date_epoch: "1652656534"

config :logger, backends: [RingLogger]

config :nerves_leds, names: [green: "led0"]

if Mix.target() == :host or Mix.target() == :"" do
  import_config "host.exs"
else
  import_config "target.exs"
end
