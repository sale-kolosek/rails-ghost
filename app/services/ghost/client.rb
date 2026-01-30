module Ghost
  class Client
    attr_reader :host

    def initialize(host = nil)
      @host = host
    end

    def get_data(page_type, params = {})
      begin
        data = Ghost::Request.call(page_type, params, host)
        return nil unless data.present?

        Ghost::Parser.new.parse(page_type, data)
      rescue Ghost::Parser::ParseError => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      rescue Ghost::Request::RequestError => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      rescue => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      end
    end
  end
end