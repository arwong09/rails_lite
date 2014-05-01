require 'uri'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    @params = route_params
    q = req.query_string
    b = req.body
    
    parse_www_encoded_form(q) unless q.nil?
    parse_www_encoded_form(b) unless b.nil?
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)
    @permitted ||= []
    @permitted.concat(keys)
  end

  def require(key)
    raise Params::AttributeNotFoundError unless @params.keys.include?(key)
  end

  def permitted?(key)
   @permitted.include?(key)
  end

  def to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private

  def parse_www_encoded_form(www_encoded_form)
    q = URI.decode_www_form(www_encoded_form)

    q.each do |query|
      query.map! { |el| parse_key(el) }
  
      i = -1
      until i.abs == query.count
        current = query[i-1]
    
        if current.count > 1
          @params.merge!(nest_hash(current, 0, query[i].first))
          break
        else
          @params.merge!( { current.first => query[i].first } )
          i -= 1
        end
      end
    end
  end
  
  def nest_hash(query, index, value)
    return value if query[index].nil? 
    { query[index] => nest_hash(query, index + 1, value) }
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
