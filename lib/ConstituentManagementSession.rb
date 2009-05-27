require 'ConvioSession'

class ConstituentManagementSession < ConvioSession
  @@login_name=nil
  
  def ConstituentManagementSession.login_name()
    return @@login_name
  end
  
  def ConstituentManagementSession.login_name=(value)
    @@login_name=value
  end
  
  @@login_password=nil
  
  def ConstituentManagementSession.login_password()
    return @@login_password
  end
  
  def ConstituentManagementSession.login_password=(value)
    @@login_password=value
  end
  
  def initialize()
    super()
    
    if @@organization
      @url=@@secure_domain+'/'+organization+'/site/SRConsAPI'
    else
      @url=@@secure_domain+'/site/SRConsAPI'
    end

    @defaultParams[:login_name]=@@login_name
    @defaultParams[:login_password]=@@login_password
  end

  # This method creates a new user record and returns the record's unique identifier.
  def create(primary_email, add_center_ids=nil, add_group_ids=nil, add_interest_ids=nil, source=nil, no_welcome=nil)
    params=@defaultParams.clone
    params[:method]="create"
    
    if primary_email
      params[:primary_email]=primary_email
    else
      puts "primary_email is required"
      return nil
    end
      
    if add_center_ids
      params[:add_center_ids]=add_center_ids
    end
    if remove_center_ids
      params[:remove_center_ids]=remove_center_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    if remove_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    
    if source
      params[:source]=source
    end
    
    if no_welcome
      params[:no_welcome]=no_welcome
    end
    
    result=convio_api_call(@url, params)
    puts "create() result: #{result}"
    return result
  end

  # This method updates an existing user record and returns the record's unique identifier.
  def update(cons_id=nil, member_id=nil, primary_email=nil, add_center_ids=nil, add_group_ids=nil, add_interest_ids=nil, remove_center_ids=nil, remove_group_ids=nil, remove_interest_ids=nil)
    params=@defaultParams.clone
    params[:method]="update"
    
    if cons_id
      params[:cons_id]=cons_id
    elsif member_id
      params[:member_id]=member_id
    elsif primary_email
      params[:primary_email]=primary_email
    else
      puts "One of cons_id, member_id, or primary_email is required"
      return nil
    end
      
    if add_center_ids
      params[:add_center_ids]=add_center_ids
    end
    if remove_center_ids
      params[:remove_center_ids]=remove_center_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    if remove_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    
    result=convio_api_call(@url, params)
    puts "update() result: #{result}"
    return result
  end

  # This method provides a convenience wrapper around the Convio Client create and update APIs. When called, this method will first try to locate* and update an existing record, and if no existing record can be found, will create a new record. See the create and update documentation for further detailed discussion of those APIs.
  def createOrUpdate(cons_id=nil, member_id=nil, primary_email=nil, add_center_ids=nil, add_group_ids=nil, add_interest_ids=nil, remove_center_ids=nil, remove_group_ids=nil, remove_interest_ids=nil, source=nil, no_welcome=nil)
    params=@defaultParams.clone
    params[:method]="createOrUpdate"
    
    if cons_id
      params[:cons_id]=cons_id
    elsif member_id
      params[:member_id]=member_id
    elsif primary_email
      params[:primary_email]=primary_email
    else
      puts "One of cons_id, member_id, or primary_email is required"
      return nil
    end
      
    if add_center_ids
      params[:add_center_ids]=add_center_ids
    end
    if remove_center_ids
      params[:remove_center_ids]=remove_center_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_group_ids
      params[:add_group_ids]=add_group_ids
    end
    if remove_group_ids
      params[:add_remove_ids]=add_remove_ids
    end
    
    if add_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    if remove_interest_ids
      params[:add_interest_ids]=add_interest_ids
    end
    
    if source
      params[:source]=source
    end
    
    if no_welcome
      params[:no_welcome]=no_welcome
    end
    
    result=convio_api_call(@url, params)
    puts "createOrUpdate() result: #{result}"
    return result
  end
  
  # This method returns a list of the constituent record fields that can be viewed or changed by the caller.
  def listUserFields(redirect=nil, access=nil)
    method="listUserFields"
  end
  
  # This method returns a list of the possible values for a constituent record field.
  def listUserFieldChoices(field)
    params=@defaultParams.clone
    params[:method]="listUserFieldChoices"

    if field
      params[:field]=field
    else
      puts "field is required"
      return nil
    end
    
    result=convio_api_call(@url, params)
    puts "listUserFieldChoices() result: #{result}"
    return result
  end

  # This method returns the constituents in a group when called from another application or server.  It is only available when called using an administrator account.
  def getGroupMembers(group_id, max_number=nil, fields=nil)
    params=@defaultParams.clone
    params[:method]="getGroupMembers"

    if group_id
      params[:group_id]=group_id
    else
      puts "field is required"
      return nil
    end
    
    if max_number
      params[:max_number]=max_number
    end
    
    if fields
      params[:fields]=fields
    end
    
    result=convio_api_call(@url, params)
    puts "getGroupMembers() result: #{result}"
    return result
  end

  # This method returns a constituent record.
  def getUser(cons_id=nil, member_id=nil, primary_email=nil, fields=nil)
    puts "getUser(#{cons_id}, #{member_id}, #{primary_email}, #{fields})"
    
    params=@defaultParams.clone
    params[:method]="getUser"
    
    if cons_id
      params[:cons_id]=cons_id
    elsif member_id
      params[:member_id]=member_id
    elsif primary_email
      params[:primary_email]=primary_email
    else
      puts "One of cons_id, member_id, or primary_email is required"
      return
    end
      
    if fields
      params[:fields]=fields
    end
    
    result=convio_api_call(@url, params)
    puts "getUser() result: #{result}"
    return result
  end

  # This method returns the groups that a constituent record is in.
  def getUserGroups(cons_id=nil, member_id=nil, primary_email=nil)
    params=@defaultParams.clone
    params[:method]="getUserGroups"
    
    if cons_id
      params[:cons_id]=cons_id
    elsif member_id
      params[:member_id]=member_id
    elsif primary_email
      params[:primary_email]=primary_email
    else
      puts "One of cons_id, member_id, or primary_email is required"
      return
    end
    
    result=convio_api_call(@url, params)
    puts "getUserGroups() result: #{result}"
    return result
  end
  
  def getUserInterests(cons_id=nil, member_id=nil, primary_email=nil)
    params=@defaultParams.clone
    params[:method]="getUserInterests"
    
    if cons_id
      params[:cons_id]=cons_id
    elsif member_id
      params[:member_id]=member_id
    elsif primary_email
      params[:primary_email]=primary_email
    else
      puts "One of cons_id, member_id, or primary_email is required"
      return
    end
    
    result=convio_api_call(@url, params)
    puts "getUserInterests() result: #{result}"
    return result
  end
end