# require "debugger"

def create_nested_hashes(array)
  return if array.nil?
  create_nested_hashes(array.first) if array.count == 1 && array.first.is_a?(Array)
  return array.first if array.count == 1 && array.first.is_a?(String)
  
  res = array.flatten if array.is_a?(Array)
  return array if array.is_a?(String)
  Hash.new(array.shift => create_nested_hashes(res))
end

 array = [["val"]]
 first = ["key"]
 # debugger
  @params[first] = create_nested_hashes(array)




# # require 'debugger'
# 
#   def parse_www_encoded_form(www_encoded_form)
#     params = {}
#     query = www_encoded_form.split(//)
#     key = []
#     value = []
#     
#     until query.empty? do
#       char = query.shift
#       # debugger
#       if char == "["
#         until char == "]"
#           char = query.shift
#           value << char unless char == '&'
#         end
#       
#         params[key.join("")] = value.join("")
#         key = []
#         value = []
#       end
#       
#       if char == "="
#         until char == '&' || char.nil?
#           char = query.shift
#           value << char unless char == '&'
#         end
#         
#         params[key.join("")] = value.join("")
#         key = []
#         value = []
#       else
#         key << char
#       end
#     end
#     
#     #iterate through each char
#     #start adding chars to a key
#     #if come upon = end the key and start adding to value
#     #if adding to value and come upon & end it and start new pair
#     
#     
#      #    
#     # 
#     # 
#     # res = URI.decode_www_form(www_encoded_form)
#     # parsed_pairs = []
#     # res.each do |key|
#     #   parsed_pairs << parse_key(key)
#     # end
#     # #when array is size 2, the last is a value and first is key
#     # #when array is size 1 it's a value
#     # #when array is bigger the first is a key pointing to the next element which is also a key
#     # p parsed_pairs
#     p params
#   end
#   a = "user[address][street]=main"
#   parse_www_encoded_form(a)
#   