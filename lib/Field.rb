require 'ConstituentManagementSession'

class Field < ConstituentManagementSession
  @constituent=nil
  @name=nil
  @label=nil
  @type=nil
  @choices=nil
  @maxChars=nil
  @value=nil
  @modified=false
  
  attr_reader :name, :label, :type, :choices, :maxChars, :value
  
  def value=(v)
    @modified=true
    @value=v
  end
  
  def initialize(cons, name, label, type, value, choices=nil, maxChars=nil)
    @constituent=cons
    @name=name
    @label=label
    @type=type
    @value=value
    @choices=choices
    @maxChars=maxChars
  end
  
  def save()
    if @modified
      @constituent.setField(@name, @value)
      @constituent.save()
    end
  end
end