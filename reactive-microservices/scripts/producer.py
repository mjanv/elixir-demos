import sys
from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers="localhost:9092")
topic = "input"
n = int(sys.argv[1])

print(f"Producing {n} messages to topic {topic}.")
for i in range(n):
    producer.send(topic, f"{i}".encode())

print("Flushing the messages.")
producer.flush()
producer.close()
print("Closing the producer.")
