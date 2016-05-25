require_relative "../test_helper"

class ClientTest < Minitest::Test
    include TestHelpers

  def setup
    @client = Client.create({identifier: "www.google.com", root_url: "www.google.com"})
    @client1 = Client.create({:root_url => "www.nytimes.com",
                              :identifier => "www.jumpstart.labs"
                              })
    @client2 = Client.create({:root_url => "www.google.com" })

    parser = Parser.new
    @string = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
    @string2 = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "parameters":[],
                "requestType":"GET",
                "eventName": "antisocialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
    @payload1 = parser.parse_payload(@string, "www.google.com")
    @payload2 = parser.parse_payload(@string2, "www.google.com")
  end

  def test_client_responds_to_payload_requests
    client = Client.new
    assert client.respond_to?(:payload_requests)
  end

  def test_client_responds_to_user_agents
    client = Client.new
    assert client.respond_to?(:user_agent_bs)
  end

  def test_client_responds_to_resolutions
    client = Client.new
    assert client.respond_to?(:resolutions)
  end

  def test_client_responds_to_requests
    client = Client.new
    assert client.respond_to?(:requests)
  end

  def test_client_responds_to_ips
    client = Client.new
    assert client.respond_to?(:ips)
  end

  def test_client_responds_to_urls
    client = Client.new
    assert client.respond_to?(:urls)
  end

  def test_client_responds_to_referrers
    client = Client.new
    assert client.respond_to?(:referrers)
  end

  def test_client_responds_to_events
    client = Client.new
    assert client.respond_to?(:events)
  end

  def test_it_validates_new_client_with_all_fields
    assert @client1.valid?
  end

  def test_it_does_not_validate_new_client_with_missing_fields
    refute @client2.valid?
  end

  def test_event_most_received_to_least
    events = @client.find_events_for_client

    assert_equal ["antisocialLogin", "socialLogin"], events.sort
  end

end
