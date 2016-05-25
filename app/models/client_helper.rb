module ClientHelper

  def find_client(identifier)
    Client.find_by(identifier: identifier)
  end

  def get_events(identifier)
		@client = find_client(identifier)
		@event_names = @client.events.pluck(:name).uniq
	end

  def find_urls_from_a_payload_requests(identifier, relativepath)
    @client = find_client(identifier)
    url = "http://#{identifier}.com/#{relativepath}"
    @single_url = @client.find_urls_by_relative_paths(url)
  end

  def find_event_data_from_payload_requests(identifier, eventname)
    @client = find_client(identifier)
    @event_text = "Number of " + eventname + "s: "
    client_events_exist?(client, eventname)
  end

  def client_events_exist?(client, eventname)
    if client.events.find_by(name: eventname)
      event_hours = format_time(eventname, client)
      create_events_by_hour_hash(event_hours)
      true
    else
      false
    end
  end

  def events_by_hour_hash(event_hours)
		@events_by_hour = event_hours.inject(Hash.new(0)) { |hash, hour| hash[hour] += 1; hash }
	end

  def format_time(eventname, client)
    client.events.find_by(name: eventname).payload_requests.where(client: client.id).pluck(:requested_at).map do |time|
			Time.parse(time).strftime("%H")
		end
  end

  def hour
    Time.zone = "UTC"
    Time.zone.parse(time).hour
  end

end
