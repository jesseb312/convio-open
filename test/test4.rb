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

testGroup='36786'

def hasTestGroup(id, testGroup)
  Constituent.constituentClass=CUConstituent
  c=Constituent.getConstituent({'id'=>id})
  return c.groups.find_all { |group| group.id==testGroup }.length>0
end

def testDelete(id, testGroup)
  puts "Testing delete..."
  Constituent.constituentClass=CUConstituent
  c=Constituent.getConstituent({'id'=>id})
  dgroups=c.groups.find_all { |group| group.id!=testGroup }
  c.groups=dgroups
  c.save()
  
  c2=Constituent.getConstituent({'id'=>id})
  if c2.groups.find_all{|group| group.id==testGroup}.length==0
    puts "Delete worked"
    return true
  else
    puts "Delete failed"
    return false
  end
end

def testAdd(id, testGroup)
  puts "Testing add..."
  c2=Constituent.getConstituent({'id'=>id})
  agroups=c2.groups
  agroups << Group.new(testGroup)
  c2.groups=agroups
  c2.save()
  
  c3=Constituent.getConstituent({'id'=>id})
  if c3.groups.find_all{|group| group.id==testGroup}.length>0
    puts "Add worked"
    return true
  else
    puts "Add Mismatch:"
    return false
  end
end

if hasTestGroup(greg2, testGroup)
  testDelete(greg2, testGroup)
  testAdd(greg2, testGroup)
else
  testAdd(greg2, testGroup)
  testDelete(greg2, testGroup)
end
