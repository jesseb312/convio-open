DISTRICT_TYPES=["home_county", "state_house_dist_id", "state_senate_dist_id", "cong_dist_id"]

class ConstituentDistrict < ConstituentManagementSession
  @id=nil
  @type=nil
  @default=nil
  @override=nil
  
  attr_reader :id, :type, :default, :override

  def initialize(id, type, default, override)
    @id=id
    @type=type
    @default=default
    @override=override
  end
end