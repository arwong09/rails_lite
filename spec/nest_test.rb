require 'URI'

www_encoded_form = "user[address][street]=main"

def parse_key(key)
  key.split(/\]\[|\[|\]/)
end

q = URI.decode_www_form(www_encoded_form)

# => [["key", "val"]]
#=> [["key", "val"], ["key2", "val2"]]
# => [["user[address][street]", "main"]]


def nest_hash(query, index, value)
  return value if query[index].nil? 
  { query[index] => nest_hash(query, index + 1, value) }
end

q.each do |query|
  query.map! { |el| parse_key(el) }
  
  i = -1
  until i.abs == query.count
    current = query[i-1]
    
    if current.count > 1
      @params = nest_hash(current, 0, query[i].first)
      break
    else
      @params.merge!( { current.first => query[i].first } )
      i -= 1
    end
  end
end


  
p @params



# 
# q.each do |pair|
#   array << parse_key(pair) 
# end
# p array
# # => [["key1"], ["val2"]]
# #=> [["user", "address", "street"], ["main"]]
# 
# # first = array.shift
# # p "HERE"
# # p array
# # p first
# # @params[first] = create_nested_hashes(array)
# 
