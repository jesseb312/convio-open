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

adminGroup=101
activeField='active'

cms=ConstituentManagementSession.new()
print "getUser:"
p cms.getUser(cons_id=greg2)
print "listUserFields:"
p cms.listUserFields()
print "getUserGroups:"
p cms.getUserGroups(greg1)
print "getUserInterests:"
p cms.getUserInterests(greg3)
print "getGroupMembers:"
p cms.getGroupMembers(adminGroup)
print 'listUserFieldChoices:'
p cms.listUserFieldChoices(activeField)
print 'createOrUpdate'
cms.createOrUpdate(cons_id=greg3)

## Methods that write to the database have not yet been tested
#cms.create(primary_email="test@test.com")
#cms.update(cons_id=greg3)
