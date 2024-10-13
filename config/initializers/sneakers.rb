require 'sneakers'

bunny_connection_options = {
  host: A9n.queue_host,
  port: A9n.queue_port,
  vhost: A9n.queue_vhost,
  username: A9n.queue_username,
  password: A9n.queue_password
}

Sneakers.configure(
  connection: Bunny.new(bunny_connection_options),
  durable: false,
  workers: 1
)