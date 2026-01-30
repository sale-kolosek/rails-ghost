module Ghost
  class Request
    class RequestError < StandardError; end

    def self.call(page_type, params, host = nil)
      request_path = Ghost::RequestPath.new(host).path(page_type, params)
      return nil unless request_path.present?

      resp = HTTParty.get(request_path)
      resp.body
    rescue => e
      raise RequestError.new(e)
    end
  end
end