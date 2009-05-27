require 'Constituent'

class CUConstituent < Constituent
  @districts=nil  
  @congressionalDistricts=nil
  @stateSenateDistricts=nil
  @stateHouseDistricts=nil
  @countyDistricts=nil
  
  def districts()
    checkDistrcts()
    return @districts.clone
  end

  def congressionalDistricts()
    checkDistrcts()
    return @congressionalDistricts.clone
  end

  def stateSenateDistricts()
    checkDistrcts()
    return @stateSenateDistricts.clone
  end
  
  def stateHouseDistricts()
    checkDistrcts()
    return @stateHouseDistricts.clone
  end

  def countyDistricts()
    checkDistrcts()
    return @countyDistricts.clone
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
    
    fields.each { |name, field|
      
    }
  end
end