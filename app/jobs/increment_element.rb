# frozen_string_literal: true

class IncrementElement
  include Sidekiq::Job

  def perform
    current_time_in_seconds = Time.current.change(usec: 0)
    matching_records = BuildQueue.where('DATE_TRUNC(\'second\', end_time) <= ? and deleted is FALSE', current_time_in_seconds)

    matching_records.each do |e|
      model_class = e.source.camelize.constantize
      record = model_class.find_by(user_id: e.user_id)

      if record
        record.increment!(e.key, e.quantity)
      end
      e.update_attribute(:deleted, true)
    end
  end
end
