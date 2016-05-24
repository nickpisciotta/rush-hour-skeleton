require_relative "../test_helper"

class UserAgentBTest < Minitest::Test
  include TestHelpers

  def setup
    @user_agent1 = UserAgentB.create({:browser => "Chrome", :platform => "Macintosh"})
    @user_agent2 = UserAgentB.create({:browser => "Firefox", :platform => ""})
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

end
