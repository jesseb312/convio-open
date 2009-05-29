require 'ConstituentManagementSession'
require 'Field'
require 'Group'
require 'Interest'

class Constituent < ConstituentManagementSession
  @@constituentClass=Constituent
  @@welcome=nil
  @@source=nil
  
  def Constituent.constituentClass()
    return @@constituentClass
  end
  
  def Constituent.constituentClass=(value)
    @@constituentClass=value
  end
  
  def Constituent.welcome()
    return @@welcome
  end
  
  def Constituent.welcome=(value)
    @@welcome=value
  end
  
  def Constituent.source()
    return @@source
  end
  
  def Constituent.source=(value)
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
    if @addCenters
      @addCentersString=@addCenters.map{|group| group.id}.join(',')
    else
      @addCentersString=nil
    end
        
    if @delCenters
      @delCentersString=@delCenters.map{|group| group.id}.join(',')
    else
      @delCentersString=nil
    end
    
    if @addGroups
      @addGroupsString=@addGroups.map{|group| group.id}.join(',')
    else
      @addGroupsString=nil
    end

    if @delGroups
      @delGroupsString=@delGroups.map{|group| group.id}.join(',')
    else
      @delGroupsString=nil
    end
    
    if @addInterests
      @addInterestsString=@addInterests.map{|group| group.id}.join(',')
    else
      @addInterestsString=nil
    end

    if @delInterest
      @delInterestsString=@delInterests.map{|group| group.id}.join(',')
    else
      @delInterestsString=nil
    end
    
    createOrUpdate(@id, @memberId, @email, @addCentersString, @addGroupsString, @addInterestsString, @delCentersString, @delGroupsString, @delInterestsString, @@source, !@@welcome)
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
    refresh()
  end
  
  def refresh()
    @fields={}
    result=getUser(cons_id=@id, member_id=@memberId, primary_email=@email)
    fieldValues=result['getConsResponse']
    
    result=listUserFields()
    fieldTypes=result['listConsFieldsResponse']['field']  
    fieldTypes.each { |data|
      name=data['name']
      label=data['label']
      type=data['valueType']
      maxChars=data['maxChars']
      
      parts=name.split('.')
      if parts.length==1
        value=fieldValues[name]      
      else
        value=fieldValues
        parts.each { |part|
          if value
            if value.class==Array
              value=value[part.to_i]
            else
              value=value[part]
            end
          end
        }
      end
  
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
    fieldTypes=result['getConsGroupsResponse']['group']  
    fieldTypes.each { |data|
      id=data['id']
      label=data['label']
      group=Group.new(id, label)
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
      @interests << interest
    }    
  end
  
  def Constituent.getConstituentByMemberId(memberId)
    return @@constituentClass.new(memberId=memberId)
  end
  
  def Constituent.getConstituentById(id)
    return @@constituentClass.new(id=id)
  end
  
  def Constituent.getConstituentByEmail(email)
    return @@constituentClass.new(email=email)
  end
  
  def compare(a, b)
    return b-a, a-b
  end
end