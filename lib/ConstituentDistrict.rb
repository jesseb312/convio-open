DISTRICT_TYPES=["home_county", "state_house_dist_id", "state_senate_dist_id", "cong_dist_id"]

class ConstituentDistrict < ConstituentManagementSession
  @constituent=nil
  @id=nil
  @type=nil
  @default=nil
  @override=nil
  @modified=false
  
  attr_reader :id, :type, :default, :override
  
  def override=(value)
    @modified=true
    @override=value
  end

  def initialize(cons, id, type, default, override)
    @constituent=cons
    @id=id
    @type=type
    @default=default
    @override=override
  end
  
  def save()
    if @modified
      @constituent.setField(@name+"_override", @override)
      @constituent.save()
    end
  end
end