require_relative "../test_helper"

class UrlTest < Minitest::Test
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
                "respondedIn":50,
                "referredBy":"www.nytimes.com",
                "requestType":"POST",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent": "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; Crazy Browser 2.0.0)",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
    @string3 = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":50,
                "referredBy":"www.nytimes.com",
                "requestType":"POST",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent": "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061030 MultiZilla/1.8.3.0a SeaMonkey/1.0.6",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
    parser.parse_payload(@string, "www.google.com")
    parser.parse_payload(@string2, "www.google.com")
    parser.parse_payload(@string3, "www.google.com")
    @url_id = @client.urls[0].id
  end

  def test_url_responds_to_payload_requests
    url = Url.new
    assert url.respond_to?(:payload_requests)
  end

  def test_url_responds_to_referrers
    url = Url.new
    assert url.respond_to?(:referrers)
  end

  def test_url_responds_to_requests
    url = Url.new
    assert url.respond_to?(:requests)
  end

  def test_url_responds_to_user_agents
    url = Url.new
    assert url.respond_to?(:user_agent_bs)
  end

  def test_url_responds_to_referrers
    url = Url.new
    assert url.respond_to?(:referrers)
  end

  def test_max_response_time
    url = Url.find(@url_id)

    max = url.max_response_time

    assert_equal 50, max
  end

  def test_min_reponse_time
    url = Url.find(@url_id)
    min = url.min_response_time

    assert_equal 37, min
  end

  def test_time_across_all_requests
    url = Url.find(@url_id)
    range = url.response_times_across_all_requests

    assert_equal [37, 50, 50], range.sort
  end

  def test_average_response_time
    url = Url.find(@url_id)
    average = url.average_response_time

    assert_equal 45, average
  end

  def test_http_verbs_associated_with_a_url
    url = Url.find(@url_id)
    verbs = url.http_verbs_associated

    assert_equal ["GET", "POST"], verbs.sort
  end

  def test_it_can_output_most_popular_referrers
    url = Url.find(@url_id)

    assert_equal ["www.nytimes.com", "http://jumpstartlab.com"], url.most_popular_referrers
  end

  def test_it_can_ouput_most_popular_user_agents
    url = Url.find(@url_id)
    user_agents = url.most_popular_user_agents

    assert_equal [["Chrome", "Macintosh"], ["Internet Explorer", "Windows"], ["Seamonkey", "Windows"]], user_agents.sort
  end

  def test_it_can_ouput_browser_breakdown
    url = Url.find(@url_id)
    browser = url.web_browser_breakdown

    assert_equal ["Chrome", "Internet Explorer", "Seamonkey"], browser.sort
  end

  def test_it_can_ouput_os_breakdown
    url = Url.find(@url_id)
    os = url.os_breakdown

    assert_equal ["Macintosh", "Windows"], os.sort
  end

end
