require 'uri'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    @params = route_params
    q = req.query_string
    parse_www_encoded_form(q) unless q.nil?
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)
  end

  def require(key)
  end

  def permitted?(key)
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    www_decoded_form = URI.decode_www_form(www_encoded_form)

    www_decoded_form.each do |param_pair|
      @params = paramify(param_pair)
    end
  end
      # TEST: paramify(["user[address][street]", "main"])
  def paramify(arr)
    keys_arr = parse_key(arr[0])
    nested_val = arr[1]

    level = @params

    keys_arr.each do |val|
      if level.has_key?(val)
        level = level[val]
        # next
        # level[val] = "wtf"
      elsif val == keys_arr.last
        level[val] = nested_val
      else
        level[val] = {}
        level = level[val]
      end
    end

    level
  end
      # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    keys_arr = key.split(/\]\[|\[|\]/)
  end
end
