require_relative "../test_helper"

class ClientTest < Minitest::Test
    include TestHelpers

  def setup
    @client1 = Client.create({:root_url => "www.google.com",
                              :identifier => "www.jumpstart.labs"
                              })
    @client2 = Client.create({:root_url => "www.google.com"
                              })
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


end
