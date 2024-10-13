require 'digest'

module ApplicationHelper
  def user_secret(date)
    generate_hash(date)
  end

  private

  def generate_hash(date)
    input = "#{date.to_s}#{A9n.hash_secret}"

    Digest::SHA256.hexdigest(input)
  end
end
