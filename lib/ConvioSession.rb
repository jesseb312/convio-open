require 'net/http'
require "net/https"

require 'json'

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
      'v'=>@@v,
      'response_format'=>@@response_format,
      'api_key'=>@@api_key,
    }                                      
  end
  
  def convio_api_call(url, params)
    puts "convio_api_call: #{url}"
    p params    
    urlp=URI.parse(url)
    http = Net::HTTP.new(urlp.host, urlp.port)
    http.use_ssl = (urlp.scheme == 'https')
    request = Net::HTTP::Post.new(urlp.path, params)
    res = http.request(request)
    
    case res
    when Net::HTTPSuccess
      return res.body
    else
      puts "body: #{res.body}"
      puts "Error in convio_api_call: #{res.error!}"
      return nil
    end
  end                                      
end