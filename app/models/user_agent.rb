class UserAgentB < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :platform, presence: true

  def web_browser_breakdown
    pluck(:browser).uniq
  end



end
