class RawmembersController < ApplicationController
  before_filter :cols

  def cols
    @columns = Rawmember.columns
  end

  def index
    @members = Rawmember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
      format.xml {render xml: @members}
    end

  end

  def show
 #   param = params["id"]
    @member = Rawmember.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member }
      format.xml {render xml: @member}
    end
  end

  def topic
    @members = Rawmember.where('topics.topic_id'=>params[:topicid].to_i)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
      format.xml {render xml: @members}
    end
  end
end

