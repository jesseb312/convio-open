require 'ConstituentManagementSession'
require 'Field'
require 'Group'
require 'Interest'

class Constituent < ConstituentManagementSession
  @@constituentClass=nil
  @@welcome=nil
  @@source=nil
  
  def constituentClass()
    return @@constituentClass
  end
  
  def constituentClass=(value)
    @@constituentClass=value
  end
  
  def welcome()
    return @@welcome
  end
  
  def welcome=(value)
    @@welcome=value
  end
  
  def source()
    return @@source
  end
  
  def source=(value)
    @@source=value
  end
  
  @fields=nil
  
  def fields()
    if @fields==nil
      refresh()
    end
    
    return @fields.clone
  end

  @email=nil
  @memberId=nil
  @id=nil
  
  attr_accessor :email, :memberId, :id  
  
  @centers=[]
  @groups=[]
  @interests=[]
  
  @addCenters=[]
  @delCenters=[]
  @addGroups=[]
  @delGroups=[]
  @addInterests=[]
  @delInterest=[]

  def centers()
    return @centers.clone
  end
  
  def centers=(value)
    adds, dels=compare(@centers, value)
    if adds.length>0
      @addCenters=@addCenters+adds
    end
    if dels.length>0
      @delCenters=@delCenters+dels
    end
    
    @centers=value
  end
  
  def groups()
    return @groups.clone
  end
  
  def groups=(value)
    adds, dels=compare(@groups, value)
    if adds.length>0
      @addGroups=@addGroups+adds
    end
    if dels.length>0
      @delGroups=@delGroups+dels
    end
    
    @groups=value
  end
  
  def interests()
    return @interests.clone
  end
  
  def interests=(value)
    adds, dels=compare(@interests, value)
    if adds.length>0
      @addInterests=@addInterests+adds
    end
    if dels.length>0
      @delInterests=@delInterests+dels
    end
    
    @interests=value
  end

  def Constituent.getConstituent(idHash)
    p "gc", idHash
    
    if idHash.has_key?('id')
      ids=idHash['id']
      if ids.class==Array
        cons=[]
        ids.each { |id|
          cons << Constituent.getOneConstituent({'id'=>id})
        }        
        return cons
      else
        return Constituent.getOneConstituent({'id'=>ids})
      end    
    elsif idHash.has_key?(:memberId)
      memberIds=idHash[:memberId]
      if memberIds.class==Array
        cons=[]
        ids.each { |id|
          cons << Constituent.getOneConstituent({:id=>id})
        }        
        return cons
      else
        return Constituent.getOneConstituent({:id=>id})
      end    
    elsif idHash.has_key?(:email)
      emails=idHash[:email]
      if ids.class==Array
        cons=[]
        ids.each { |id|
          cons << Constituent.getOneConstituent({:id=>id})
        }
        return cons
      else
        return Constituent.getOneConstituent({:id=>id})
      end    
    end
  end
  
  def Constituent.getOneConstituent(idHash)    
    p "goc", idHash
    if idHash.has_key?('id')
      value=idHash['id']
      return Constituent.getConstituentById(value)
    elsif idHash.has_key?(:memberId)
      value=idHash[:memberId]
      return Constituent.getConstituentByMemberId(value)
    elsif idHash.has_key?(:email)
      value=idHash[:email]
      return Constituent.getConstituentByEmail(value)
    else
      puts "meberID, id, or email required"
      return nil
    end
  end

  def save()
    createOrUpdate(@id, @memberId, @email, @addCenters, @addGroups, @addInterests, @delCenters, @delGroups, @delInterests, @@source, !@@welcome)
    @addCenters=[]
    @addGroups=[]
    @addInterests=[]
    @delCenters=[]
    @delGroups=[]
    @delInterests=[]
  end

  def convio_attr_read(fieldList)
    fieldList.each { |name| 
      code="def #{name}; return fields[name]; end;"+
           "def #{name}=(value); fields[name]=value; end;"
      self.class_eval(code)
    }
  end

#  def convio_attr_write(fieldList)
#  end
  
#  def convio_attr_accessor(fieldList)
#  end
  
  private

  def initialize(id=nil, memberId=nil, email=nil)
    super()
    
    @id=id
    @memberId=memberId
    @email=email
    
    save()
#    refresh()
  end
  
  def refresh()
    @fields={}
    result=getUser(cons_id=@id, member_id=@memberId, primary_email=@email)
    fieldValues=result['getConsResponse']
    
    result=listUserFields()
    puts "result:"
    p result
    fieldTypes=result['listConsFieldsResponse']['field']  
    fieldTypes.each { |data|
      name=data['name']
      label=data['label']
      type=data['valueType']
      maxChars=data['maxChars']
  
      value=fieldValues[name]
      
      if type=='ENUMERATION'
        result=listUserFieldChoices(name)
        choices=result['listConsFieldChoicesResponse']['choice']
      else
        choices=nil
      end
      
      field=Field.new(name, label, type, value, choices, maxChars)
      @fields[name]=field
    }

    @groups=[]
    result=getUserGroups(cons_id=@id)
    puts "result:"
    p result
    fieldTypes=result['getConsGroupsResponse']['group']  
    fieldTypes.each { |data|
      id=data['id']
      label=data['label']
      group=Group.new(id, label)
      puts "appending #{@groups} #{group}"
      @groups << group
    }

    @interests=[]
    result=getUserInterests(id=@id)
    fieldTypes=result['getConsInterestsResponse']['interest']  
    fieldTypes.each { |data|
      id=data['id']
      label=data['label']
      path=data['path']
      for_email=data['for_email']
      for_web=data['for_web']
      
      interest=Interest.new(id, label, path, for_email, for_web)
      @interests << interests
    }    
  end
  
  def Constituent.getConstituentByMemberId(memberId)
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Constituent.new(memberId=memberId)
    end
  end
  
  def Constituent.getConstituentById(id)
    puts "gcbi #{id}"
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Constituent.new(id=id)
    end
  end
  
  def Constituent.getConstituentByEmail(email)
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Constituent.new(email=email)
    end
  end
  
  def compare(a, b)
    return b-a, a-b
  end
end