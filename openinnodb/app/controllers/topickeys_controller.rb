class TopickeysController < ApplicationController
  def index
    @topickeys=Topickey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topickeys }
      format.xml { render xml: @topickeys }
    end

  end

  def statistics
    @topickeys=Topickey.order_by([:freq, :desc]).limit(20)


  end
end
