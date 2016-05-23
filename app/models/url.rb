class Url < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence:true

  def max_response_time
    payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.min_response_time
  end

end
