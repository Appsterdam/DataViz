class MembersController < ApplicationController

  def index
    @members = Member.all
    @columns = Member.columns
    @columns_long=["link",]

  end

  def show
 #   param = params["id"]
    @member = Member.find(params[:id])
  end
end
