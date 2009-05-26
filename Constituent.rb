require 'ConstituentManagementSession'

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
  
  @fields={}
  
  attr_reader :fields

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
    if idHash.containsKey(:memberId)
      value=idHash[:memberId]
      if type(value)==list:
      else
      end
    elsif idHash.containsKey(:id)
      value=idHash[:id]
      if type(value)==list:
      else
      end
    elsif idHash.containsKeys(:email)
      value=idHash[:email]
      if type(value)==list:
      else
      end
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
    @id=id
    @memberId=memberId
    @email=email
    
    save()
    refresh()
  end
  
  def refresh()
    @fields={}
    result=getUser(cons_id=@id, member_id=@memberId, primary_email=@email)
    fieldValues=result['getConsResponse']
    
    result=listUserFields()
    fieldTypes=result['listConsFieldsResponse']['field']  
    resp.each { |data|
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
      
      field=new Field(name, label, type, value, choices, maxChars)
      @fields[name]=field
    }
    
    result=getUserGroups()
    fieldTypes=result['listConsGroupsResponse']['group']  
    resp.each { |data|
      id=data['id']
      label=data['label']
      group=new Group(id, label)
      @groups << group
    }
    
    result=getUserInterests()
    fieldTypes=result['listConsInterestsResponse']['interest']  
    resp.each { |data|
      id=data['id']
      label=data['label']
      path=data['path']
      for_email=data['for_email']
      for_web=data['for_web']
      
      interest=new Interest(id, label, path, for_email, for_web)
      @interests << interests
    }    
  end
  
  def Constituent.getConstituentByMemberId(memberId)
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Consituent.new(memberId=memberId)
    end
  end
  
  def Constituent.getConstituentById(id)
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Consituent.new(id=id)
    end
  end
  
  def Constituent.getConstituentByEmail(email)
    if @@constituentClass    
      puts "constituentClass not yet supported"
      return nil
    else
      return Consituent.new(email=email)
    end
  end
  
  def compare(a, b)
    return b-a, a-b
  end
end