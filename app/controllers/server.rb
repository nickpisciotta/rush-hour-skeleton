module RushHour
require_relative "../models/client_helper"

  class Server < Sinatra::Base
    include ClientHelper


    post '/sources' do
      client_validator = RequestValidator.new
      result = client_validator.client_request_validation(params)

      status (result[0])
      body (result[1])
    end

    post '/sources/:identifier/data' do |identifier|
      request_validator = RequestValidator.new
      result = request_validator.data_request_validation(identifier, params)

      status (result[0])
      body (result[1])
    end

    get '/sources/:IDENTIFIER' do |identifier|
      @client = Client.find_by(identifier: identifier)
        if @client.nil?
          body "The identifier does not exist."
        elsif @client.payload_requests.exists?
          body "Ok"
          erb :index
        else
          body "No payload data has been received for this source."
        end
    end

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |identifier, relativepath|
      find_urls_from_a_payload_requests(identifier, relativepath)
      @single_url.valid? ?  (erb :show) : (erb :not_requested)
    end

    get '/sources/:IDENTIFIER/events/:EVENTNAME' do |identifier, eventname|
      event_exists = parse_event_data(identifier, eventname)
      event_exists ? (erb :events) : (erb :no_event)
    end

    get '/sources/:IDENTIFIER/events' do |identifier|
      get_events(identifier)
      erb :client_events
    end

    not_found do
      erb :error
    end

  end
end
