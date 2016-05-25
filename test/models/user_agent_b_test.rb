require_relative "../test_helper"

class UserAgentBTest < Minitest::Test
  include TestHelpers

  def setup
    @user_agent1 = UserAgentB.create({:browser => "Chrome", :platform => "Macintosh"})
    @user_agent2 = UserAgentB.create({:browser => "Firefox", :platform => ""})
    @user_agent3 = UserAgentB.create({:browser => "Firefox", :platform => "Windows"})
  end

  def test_it_validates_new_referrer_with_all_fields
    assert @user_agent1.valid?
  end

  def test_it_does_not_validate_new_referrer_with_missing_fields
    refute @user_agent2.valid?
  end

  def test_user_agent_responds_to_payload_requests
    assert @user_agent1.respond_to?(:payload_requests)
  end

  def test_user_agent_web_browser_breakdown_returns_unique_browsers
    assert_equal ["Chrome", "Firefox"], UserAgentB.web_browser_breakdown
  end

  def test_user_agent_os_breakdown_returns_unique_os
    assert_equal ["Macintosh", "Windows"], UserAgentB.os_breakdown
  end

end
