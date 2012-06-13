class MembersController < ApplicationController

  def index
    @members = Member.all
    @columns = Member.columns
  end

  def show
 #   param = params["id"]
    @member = Member.find(params[:id])
  end
end
