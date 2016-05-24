require_relative "../test_helper"

class EventTest < Minitest::Test
  include TestHelpers

  def setup
    @event1 = Event.create({name: "socialLogin"})
    @event2 = Event.create({})
  end

  def test_event_is_valid_given_all_attributes
    assert @event1.valid?
  end

  def test_event_is_not_valid_if_name_is_not_given
    refute @event2.valid?
  end

  def test_event_responds_to_payload_requests
    assert @event1.respond_to?(:payload_requests)
  end

end
