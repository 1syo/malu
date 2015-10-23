module Validation
  def ensure_format(key)
    if key =~ %r{\A(GET|PUT|POST|DELETE|HEAD)\s\/[a-z0-9_]+\z}
      true
    else
      false
    end
  end

  def ensure_url(value)
    return false unless value =~ URI.regexp

    begin
      URI.split(value)
    rescue URI::InvalidURIError
      return false
    end

    true
  end
end
