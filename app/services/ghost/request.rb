module Ghost
  class Request
    class RequestError < StandardError; end

    def self.call(page_type, params)
      request_path = Ghost::RequestPath.new.path(page_type, params)
      
      resp = HTTParty.get(request_path)
      resp.body
    rescue => e
      raise RequestError.new(e)
    end
  end
end