class ChatController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def send_message
    user_message = params[:message]
    
    # Construct the message with context
    with_message = <<~CONTEXT
      Brew Blessed
      motto : Experience Premium Coffee
              Sourced from the world's finest coffee regions 
              
      Ethiopian Yirgacheffe ($18.99)
      Bright and fruity with notes of citrus, berries, and a floral aroma.

      Colombian Supremo ($16.99)
      Well-balanced with a rich caramel sweetness and a touch of nuttiness.

      Sumatra Mandheling ($19.99)
      Full-bodied with earthy flavors, herbal notes, and low acidity.

      Guatemala Antigua ($17.99)
      Complex with chocolate undertones, spice notes, and a smooth finish.
      About Brew Blessed
      Committed to Quality Since 2010

      At Brew Blessed, we believe that every cup of coffee tells a story. Our journey began with a simple mission: to bring the world's finest coffee directly to your cup.
      We carefully select beans from sustainable farms across the globe, working directly with farmers to ensure ethical practices and the highest quality.
      Our master roasters bring decades of experience to create perfectly balanced roasts that highlight the unique characteristics of each origin.

      Contact
       123 Coffee Street, Brewville
       +1 (555) 123-4567
       info@brewbleessed.com

      kamu berperan sebagai customer support dari Brew Blessed, kamu harus menjawab pertanyaan customer dengan baik dan benar.
      jika pelanggan bertanya "#{user_message}" tolong jawab!
    CONTEXT

    # API endpoint for Gemini 
    api_key = Rails.application.credentials.dig(:gemini, :api_key)
    uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{api_key}")
    
    # Request data
    request_data = {
      contents: [{
        parts: [{ text: with_message }]
      }]
    }
    
    # Make HTTP request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.body = request_data.to_json
    
    response = http.request(request)
    
    if response.code == "200"
      result = JSON.parse(response.body)
      
      # Extract response text
      bot_response = "I'm sorry, I couldn't process your request."
      
      if result && 
         result["candidates"] && 
         result["candidates"][0] && 
         result["candidates"][0]["content"] && 
         result["candidates"][0]["content"]["parts"] && 
         result["candidates"][0]["content"]["parts"][0]
        bot_response = result["candidates"][0]["content"]["parts"][0]["text"]
      end
      
      render json: { response: bot_response }
    else
      render json: { response: "I'm sorry, I'm having trouble connecting right now. Please try again later." }, status: 500
    end
  end
end