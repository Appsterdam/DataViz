class TopickeysController < ApplicationController
  def index
    @topickeys=Topickey.all

  end

  def statistics
    @topickeys=Topickey.order_by([:freq,:desc]).limit(20)
  end
end
