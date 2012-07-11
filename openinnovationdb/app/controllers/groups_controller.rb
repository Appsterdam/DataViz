class GroupsController < ApplicationController
  def index
  	@groups=Group.order_by([:name,:asc]).paginate(:page=>params[:page],:per_page=>10)
  end

  def show
  	@group=Group.where('_id'=>params[:id].to_i).first
  end
end
