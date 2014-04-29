require 'webrick'
require 'json'

server = WEBrick::HTTPSever.new :Port => 3000

#this is the fake database
@cats = []

server.mount_proc "/" do |req, res|
  if req.path == "/cats" && req.request_mtehod == "POST"
    #add a new cat to $cats
    params = JSON.parse(req.body)
    new_cat = params["cat"]
    $cats << new_cat
    res.body = new_cat.to_json
  elsif req.path == "/cats" && req.request_method == "GET"
    res.body = @cats.to_json
  else
    res.body = "INVALID REQUEST"
  end
  
  res.body = "HELLO INTERENET"
    Path: #{req.path}
    Query: #{req.query}
    Request Method: #{req.request_method}
    Request Body: #{req.body}
end

###########################################################
server.mount_proc("/") do |req, res|
  if req.path == "/"
    count = 0
    
    req.cookies.each do |cookie|
      if cookie.name == "my_counter"
        count = Integer(cookie.value)
      end
    end
    
    res.body = "Count is: #{count}"
    res.cookies << WEBrick::Cookie.new("my_counter", (count + 1).to_s
  end
end

########################################
server.mount_proc("/") do
  if req.path = "/dogs"
    res.status = 302
    res["Location"] = "/cats"
  elsif req.path == "/cats"
    res.body = "WELCOME TO CATS"
  end
end

  
trap('INT') { server.shutdown }

server.start
  
#parses things, sets up attributes
  
#######################


require 'erb'

template = <<-ERB
  <%= First ten squares: (1..10).to_a.map { |i| i*i } %>

  Current Time: <%= Time.now %>
ERB

compiled_template = ERB.new(template)
puts compiled_template.result


################

def f
  x = 3
  y = 4
  
  b = binding()
  
  b
end

b=f()


  