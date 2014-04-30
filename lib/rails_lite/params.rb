require 'uri'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    @params = {}
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
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    q = URI.decode_www_form(www_encoded_form)
    q = q.first
    array = []
    
    q.each do |pair|
      array << parse_key(pair) 
    end
    first = array.shift
    p "HERE"
    p array
    p first
    @params[first] = create_nested_hashes(array)
  end
  
  def create_nested_hashes(array)
    return if array.nil?
    create_nested_hashes(array.first) if array.count == 1 && array.first.is_a?(Array)
    return array.first if array.count == 1 && array.first.is_a?(String)
    Hash.new(array.shift => create_nested_hashes(array.first))
  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
