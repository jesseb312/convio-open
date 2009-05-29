class Group
  @id=nil
  @label=nil
  
  attr_reader :id, :label

  @members=nil
  @changed=[]
  
  def members()
    if @members
      return @members
    else
      refresh()
      return @members.clone
    end
  end
  
  def members=(value)
    adds, dels=compare(@members, value)
    
    adds.each { |constituent|
      groups=constituent.groups
      groups << this
      constituent.groups=groups
      
      @changed << constituent
    }
    
    dels.each { |constituent|
      groups=constituent.groups
      groups.remove(this)
      constituent.groups=groups
      
      @changed << constituent      
    }
    
    @members=value
  end
  
  def initialize(id, label=nil)
    @id=id
    @label=label
  end
  
  def save()
    @changed.each { |constituent|
      constituent.save()
    }
  end
  
  private
  
  def refresh()
    result=getGroupMembers(@id)
    fieldTypes=result['listConsGroupMembersResponse']['member']  
    resp.each { |data|
      cons_id=data['cons_id']
      
      member=Constituent.getConstituent({:id=>cons_id})
      members << member
    }    
  end  
end