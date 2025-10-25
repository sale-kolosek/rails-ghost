module Ghost
  class Parser
    class ParseError < StandardError; end

    def parse(method_name, data)
      send(method_name, data)
    rescue => e
      raise ParseError.new(e)
    end

    private

    def pages(data)
      JSON.parse(data)['pages']
    end

    def page(data)
      JSON.parse(data)['pages']&.first
    end
    
    def post(data)
      JSON.parse(data)['posts'].first
    end

    def posts(data)
      JSON.parse(data)['posts'] || []
    end

    def settings(data)
      JSON.parse(data)['settings']
    end
  end
end

