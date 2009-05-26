require 'ConstituentManagementSession'

class Field < ConstituentManagementSession
  @name=nil
  @label=nil
  @type=nil
  @choices=nil
  @maxChars=nil
  @value=nil
  
  attr_reader :name, :label, :type, :choices, :maxChars, :value  
  
  def initialize(name, label, type, value, choices=nil, maxChars=nil)
    @name=name
    @label=label
    @type=type
    @value=value
    @choices=choices
    @maxChars=maxChars
  end
end