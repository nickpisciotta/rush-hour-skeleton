require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
    include TestHelpers

  def setup
    @client = Client.create({identifier: "www.google.com", root_url: "www.google.com"})
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
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
    @string3 = '{
                "url":"www.example.com",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn": "50",
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "antisocialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1900",
                "resolutionHeight":"1200",
                "ip":"63.29.38.211"
              }'
    @string4 = '{
                "url":"www.example.com",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn": "75",
                "referredBy":"http://jumpstartlab.com",
                "requestType":"POST",
                "parameters":[],
                "eventName": "antisocialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1900",
                "resolutionHeight":"1200",
                "ip":"63.29.38.211"
              }'
  @payload1 = parser.parse_payload(@string, "www.google.com")
  @payload2 = parser.parse_payload(@string2, "www.google.com")
  @payload3 = parser.parse_payload(@string3, "www.google.com")
  @payload4 = parser.parse_payload(@string4, "www.google.com")

  # @payload =  PayloadRequest.create({
  #                         :url_id=> "1",
  #                         :requested_at=> "2015-02-20",
  #                         :responded_in=> 37,
  #                         :referrer_id=> "http://jumpstartlab.com",
  #                         :request_id=> 2,
  #                         :parameters=> [],
  #                         :event_id=> 1,
  #                         :user_agent_b_id=> "1",
  #                         :resolution_id=> "1",
  #                         :ip_id=> "63.29.38.211"
  #                         })
  #
  # @payload2 = PayloadRequest.create({
  #                         :url_id=> "1",
  #                         :requested_at=> "",
  #                         :responded_in=> 100,
  #                         :referrer_id=> "http://jumpstartlab.com",
  #                         :request_id=> 1,
  #                         :parameters=> [],
  #                         :event_id=> 2,
  #                         :user_agent_b_id=> "1",
  #                         :resolution_id=> "2",
  #                         :ip_id=> "63.19.32.211"
  #                         })
  # @payload3 = PayloadRequest.create({
  #                         :url_id=> "1",
  #                         :requested_at=> "2015-06-06",
  #                         :responded_in=> 100,
  #                         :referrer_id=> "http://jumpstartlab.com",
  #                         :request_id=> 1,
  #                         :parameters=> [],
  #                         :event_id=> 2,
  #                         :user_agent_b_id=> "1",
  #                         :resolution_id=> "2",
  #                         :ip_id=> "63.19.32.211"
  #                         })
  # @payload4 = PayloadRequest.create({
  #                         :url_id=> "2",
  #                         :requested_at=> "2015-06-06",
  #                         :responded_in=> 100,
  #                         :referrer_id=> "http://jumpstartlab.com",
  #                         :request_id=> 1,
  #                         :parameters=> [],
  #                         :event_id=> 2,
  #                         :user_agent_b_id=> "1",
  #                         :resolution_id=> "2",
  #                         :ip_id=> "63.19.32.211"
  #                         })
  end

  def test_it_validates_new_payload_request_with_all_fields
    assert @payload1.valid?
  end

  def test_it_does_not_validate_new_payload_request_with_missing_fields
    refute @payload2.valid?
  end

  def test_payload_request_responds_to_client
    payload = PayloadRequest.new
    assert payload.respond_to?(:client)
  end
  def test_payload_request_responds_to_user_agent
    payload = PayloadRequest.new
    assert payload.respond_to?(:user_agent_b)
  end
  def test_payload_request_responds_to_resolution
    payload = PayloadRequest.new
    assert payload.respond_to?(:resolution)
  end
  def test_payload_request_responds_to_url
    payload = PayloadRequest.new
    assert payload.respond_to?(:url)
  end
  def test_payload_request_responds_to_event
    payload = PayloadRequest.new
    assert payload.respond_to?(:event)
  end
  def test_payload_request_responds_to_ip
    payload = PayloadRequest.new
    assert payload.respond_to?(:ip)
  end
  def test_payload_request_responds_to_referrer
    payload = PayloadRequest.new
    assert payload.respond_to?(:referrer)
  end
  def test_payload_request_responds_to_request
    payload = PayloadRequest.new
    assert payload.respond_to?(:request)
  end

  def test_average_response_time
    time = PayloadRequest.average_response_time

    assert_equal 54, time
  end

  def test_most_frequent_request_type
    top = PayloadRequest.most_frequent_request_type

    assert_equal "GET", top
  end

  def test_url_most_requested_to_least
    urls = PayloadRequest.url_most_requested_to_least

    assert_equal ["www.example.com", "http://jumpstartlab.com/blog"], urls
  end

  def test_event_most_received_to_least
    events = PayloadRequest.event_most_received_to_least

    assert_equal ["antisocialLogin", "socialLogin"], events
  end

  def test_if_all_http_verbs_are_returned
    verbs = PayloadRequest.all_http_verbs

    assert_equal ["GET", "POST"], verbs
  end

  def test_max_response_times_for_all_requests
    max = PayloadRequest.max_response_time

    assert_equal 75, max
  end

  def test_min_response_times_for_all_requests
    min = PayloadRequest.min_response_time

    assert_equal 37, min
  end

end
