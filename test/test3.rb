require 'ConvioSession'
require "ConstituentManagementSession"
require 'Constituent'
require 'CUConstituent'

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

Constituent.constituentClass=CUConstituent
c=Constituent.getConstituent({'id'=>greg2})
#puts "c:"
#p c
puts "districts:"
p c.districts
puts "congressionalDistrict:"
p c.congressionalDistrict