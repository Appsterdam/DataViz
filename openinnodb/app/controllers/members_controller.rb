class MembersController < ApplicationController

  def show
    @members = Member.all.to_a
    @columns = Member.columns
  end

  def showid
    param = params["id"]
    @member = Member.find(param)
  end
end
