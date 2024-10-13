# frozen_string_literal: true

class FleetWorker
  include ApplicationHelper

  ROUTING_KEY = 'qgame_app.fleet_build'.freeze

  include Sneakers::Worker
  from_queue 'fleet_build', exchange: 'qgame_app', exchange_type: :direct, routing_key: ROUTING_KEY

  def work(data)
    result = JSON.parse(data)
    build_queue = BuildQueue.find_by(secret_hash: result["secret_hash"], user_id: result["user_id"])

    if user_secret(result["end_time"]) == result["secret_hash"] && !build_queue.present?
      BuildQueue.create(result)
    end
  end
end
