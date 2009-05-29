require 'ConvioSession'
require "ConstituentManagementSession"
require 'Constituent'

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

adminGroup=101
activeField='active'

c=Constituent.getConstituent({'id'=>greg3})
print "name.first:"
p c.fields['name.first']

c.setField('name.first', 'Lalala')
c.save()

c2=Constituent.getConstituent({'id'=>greg3})
print "name.first:"
p c2.fields['name.first']

cms=ConstituentManagementSession.new()
cms.update(greg3, nil, nil, nil, nil, nil, nil, nil, nil, {'name.first'=>"Greg"})
