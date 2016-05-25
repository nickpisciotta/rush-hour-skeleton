class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agent_bs, :through => :payload_requests
  has_many :resolutions,   :through => :payload_requests
  has_many :requests,      :through => :payload_requests
  has_many :ips,           :through => :payload_requests
  has_many :urls,          :through => :payload_requests
  has_many :referrers,     :through => :payload_requests
  has_many :events,        :through => :payload_requests

  validates :root_url,      presence: true, uniqueness: true
  validates :identifier,    presence: true, uniqueness: true

  def valid_params(params)
    Client.exists?(params)
  end

  def find_urls
    urls.pluck(:address).uniq
  end

  def find_urls_by_relative_paths(path)
    urls.where(address: path).uniq.first
  end

  def find_events_for_client
    events.group(:name).order(count: :desc).count.keys 
  end


end
