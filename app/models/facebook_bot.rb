class FacebookBot

  def send_message(data)
    @recyle = "EAAWFZC1PtQBkBAKme2REZAoM15PBN0qbj3ffUg7zYTvtIAeZCqwQqXjtwSZBgrun4cASHh2TZAZAC2yNupuT8jALIh5SZCmhgEdTA9cZA3ocfGtPqnHdBJDLYO5Ot13u7JPfGbWjguJuQrXrN1VZARyqq3Vw5St2m4RqzouyZCsAzQKgZDZD"
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAADPNdIZC3IEBAB2CFEIZB1anPRc5HHayZCTc7R6OZA9rrXdAQoqAEi6t8FRUFiyzqdMrVlgw82eP401PWzrCgovqVo2gLew704Aq756qQZAMsCoxdSQeGF3sZAu6u0rk9sUpgXFHNs9kc9b7Sxy0DZByTO1refCQyWKMW1J9PwVwZDZD") #alephants - jobs page token
    #url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAWeZAstWY4kBAGMrOQHZBxTYw4eau932CE620f1cVwwKCuhmZAHwtRL5jZAEPoetaFa9CJNd97BGYMiV2OZAljpAXRzY9B3cJSaD6GoLJJM0I4dZBQZCTH39c1Kk2N1ZCZBsqf3ZAZCIarcG1e4oKOkJZArW1fxAbpNcBOPw3hQG6MTsQZDZD")
  
    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    begin
      request = Net::HTTP::Post.new(url.request_uri)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      response = http.request(request)
      body = JSON(response.body)
      return { ret: body["error"].nil?, body: body }
    rescue => e
      raise e
    end
  end

  def send_text_message(sender, text)
    data = {
      recipient: { id: sender },
      message: { text: text }
    }
    send_message(data)
  end

  def send_generic_message(sender, load)
    data = {
      recipient: { id: sender },
      message: load
    }
    send_message(data)
  end

end
