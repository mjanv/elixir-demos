import json

from kafka import KafkaConsumer

consumer = KafkaConsumer(
    "output",
    bootstrap_servers=["localhost:9092"],
    auto_offset_reset="earliest",
    enable_auto_commit=True,
)

for message in consumer:
    print(json.loads(message.value))
