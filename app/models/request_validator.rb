class RequestValidator

  def data_request_validation(identifier, params)
    parser = Parser.new
    client = Client.find_by(identifier: identifier)
    if client.nil?
      return[403, "Url does not exist"]
    elsif parser.parse_payload(params[:payload], identifier)
      @errors = parser.payload.errors.full_messages.join(", ")
      if @errors.include?("can't be blank")
        return [400, "Payload is missing"]
      elsif @errors.include?("already been taken")
        return [403, "Payload already received"]
      else
        return [200, "OK"]
      end
    end
  end

  def client_request_validation(params)
    ca = ClientAnalyzer.new(params)
    new_param = ca.parse_client_params
    client = Client.new(new_param)
    if client.valid_params(new_param) == true
      return [403, "Client already exists."]
    elsif client.save
      return [200, "Client creation successful!"]
    else
      return [400, "Client identifier or root url not provided."]
    end
  end

end
