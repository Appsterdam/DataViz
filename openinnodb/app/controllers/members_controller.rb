class MembersController < ApplicationController
  before_filter :cols

  def cols
    @columns = Member.columns
  end

  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
      format.xml {render xml: @members}
    end

  end

  def show
 #   param = params["id"]
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member }
      format.xml {render xml: @member}
    end
  end

  def topic
    @members = Member.where('topics.topic_id'=>params[:topicid].to_i)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
      format.xml {render xml: @members}
    end
  end
end
