cd ui/
export MIX_TARGET=host
export MIX_ENV=dev

mix deps.get
mix assets.deploy

cd ../

cd firmware/

export MIX_TARGET=rpi0
export MIX_ENV=dev

mix deps.get
mix firmware
mix upload nerves.local
# mix burn
cd ../