class GroupsController < ApplicationController
  def index
  	@groups=Group.order_by([:name,:asc]).paginate(:page=>params[:page],:per_page=>10)
    @groupsall=Group.all
    respond_to do |format|
      format.html
      format.json {render json: @groupsall,:except=>[:_id,:created,:urlname ]}
    end
  end

  def show
  	@group=Group.where('_id'=>params[:id].to_i).first

    respond_to do |format|
      format.html
      format.json {render json:@group,:except=>[:_id,:created,:urlname ]}
    end
  end
end
