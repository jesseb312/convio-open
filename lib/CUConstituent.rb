require 'Constituent'
require 'ConstituentDistrict'

class CUConstituent < Constituent
  @districts=nil  
  @congressionalDistrict=nil
  @stateSenateDistrict=nil
  @stateHouseDistrict=nil
  @countyDistrict=nil
  
  def districts()
    checkDistricts()
    return @districts.clone
  end

  def congressionalDistrict()
    checkDistricts()
    return @congressionalDistrict
  end

  def stateSenateDistrict()
    checkDistricts()
    return @stateSenateDistrict
  end
  
  def stateHouseDistrict()
    checkDistricts()
    return @stateHouseDistrict
  end

  def countyDistrict()
    checkDistricts()
    return @countyDistrict
  end
  
  private
  
  def checkDistricts()
    if @districts==nil
      refreshDistricts()
    end
  end
  
  def refreshDistricts()
    if @fields==nil
      refresh()
    end
    
    @districts=[]    
    
    districts=fields['districts']
    DISTRCT_TYPES.each { |type|
      default=districts[type]
      override=districts[type+'_override']
      district=ConstituentDistrict.new(@id, type, default, override)
      
      @districts << district
      
      if type=='home_county'
        @countDistricts=district
      elsif type=='state_house_dist_id'
        @stateHouseDistrict=district
      elsif type=='state_senate_dist_id'
        @stateSenateDistrict=district
      elsif type=='cong_dist_id'
        @congressionalDistrict=district
      else
        puts "Error: unsupported district type: #{type}"
      end
    }
  end
end