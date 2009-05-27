require "ConstituentManagementSession"

puts "v: #{ConvioSession.v()}"

ConvioSession.secure_domain="https://secure.consumersunion.org"
ConvioSession.organization=nil

ConvioSession.response_format="json"
ConvioSession.api_key="Js9UI3SlSkj74kuwlsSn"

ConstituentManagementSession.login_name="brandon@moontower.us"
ConstituentManagementSession.login_password="a7892wlksl"

greg1=3265775
greg2=3483397
greg3=3441832

cms=ConstituentManagementSession.new()
cms.getUser(cons_id=greg1)