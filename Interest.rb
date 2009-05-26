require 'ConstituentManagementSession'

class Interest < ConstituentManagementSession
  @id=nil
  @label=nil
  @path=nil
  @forEmail=nil
  @forWeb=nil
  
  attr_reader :id, :label, :path, :forEmail, :forWeb
  
  def initialize(id, label, path, forEmail, forWeb)
    @id=id
    @label=label
    @path=path
    @forEmail=forEmail
    @forWeb=forWeb
  end
end