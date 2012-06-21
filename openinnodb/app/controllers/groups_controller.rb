class GroupsController < ApplicationController
  def index
    @groups=Groupsa.all
  end

  def show
    @group=Groupsa.where('_id'=>params[:id].to_i).first
  end
end
