class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers,      through: :payload_requests
  has_many :requests,       through: :payload_requests
  has_many :user_agent_bs,  through: :payload_requests

  validates :address, presence:true

  def max_response_time
    payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def average_response_time
    payload_requests.average(:responded_in).truncate
  end

  def http_verbs_associated
    requests.pluck(:verb).uniq
  end

  def most_popular_referrers
    referrers.group(:address).order(count: :desc).count.keys.take(3)
  end

  def most_popular_user_agents
    user_agent_bs.group(:browser, :platform).order(count: :desc).count.keys.take(3)
  end

  def web_browser_breakdown
    user_agent_bs.pluck(:browser).uniq
  end

  def os_breakdown
    user_agent_bs.pluck(:platform).uniq
  end

  def response_times_across_all_requests
    payload_requests.pluck(:responded_in).reverse
  end

end
