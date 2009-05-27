require 'net/http'

require 'rubygems'
require_gem 'json'

class ConvioSession
  @@v="1.0"
  
  def ConvioSession.v()
    return @@v
  end
  
  def ConvioSession.v=(value)
    @@v=value
  end
  
  @@response_format="json"
  
  def ConvioSession.response_format()
    return @@response_format
  end
  
  def ConvioSession.response_format=(value)
    @@response_format=value
  end
  
  @@secure_domain=nil
  
  def ConvioSession.secure_domain()
    return @@secure_domain
  end
  
  def ConvioSession.secure_domain=(value)
    @@secure_domain=value
  end

  @@organization=nil
  
  def ConvioSession.organization()
    return @@organization
  end
  
  def ConvioSession.organization=(value)
    @@organization=value
  end

  @@api_key=nil

  def ConvioSession.api_key()
    return @@api_key
  end
  
  def ConvioSession.api_key=(value)
    @@api_key=value
  end

  @defaultParams={}
  
  def initialize()
    if !@@secure_domain || !@@api_key
      puts "Not all required fields are present"
      return
    end
    
    @defaultParams={
      :v=>@@v,
      :response_format=>@@response_format,
      :api_key=>@@api_key,
    }                                      
  end
  
  def convio_api_call(url, params)
    puts "convio_api_call: #{url}"
    p params
    res = Net::HTTP.post_form(URI.parse(url), params)                                    
    case res
      when Net::HTTPSuccess
        return JSON.parse(res.body)
      else
        puts "Error in convio_api_call: #{res.error!}"
        return nil
    end                                      
  end
end