require "administrate/field/base"

class JsonTooltipField < Administrate::Field::Base
  def truncated
    return "" if data.blank?

    json = data.is_a?(String) ? data : data.to_json
    json.truncate(40)
  end

  def formatted_json
    return "" if data.blank?

    if data.is_a?(Hash) || data.is_a?(Array)
      JSON.pretty_generate(data)
    else
      data.to_s
    end
  end
end
