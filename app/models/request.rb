class Request < ActiveRecord::Base
  has_many :payload_requests

  validates :verb , presence: true 
end