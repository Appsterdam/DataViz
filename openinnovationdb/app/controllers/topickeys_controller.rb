class TopickeysController < ApplicationController
  def index
  	@topickeys=Topickey.order_by([:freq,:desc]).paginate(:page=>params[:page],:per_page=>20)
    @topickeysall=Topickey.all
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topickeysall,:except=>[:_id] }
      format.xml { render xml: @topickeysall,:except=>[:_id]}
    end

  end

  def filtered
  	@android_titles=Topickey.android.map(&:title)
  	@ios_titles=Topickey.ios.map(&:title)
  	@android_sum=Topickey.android.map(&:freq).sum 
  	@ios_sum=Topickey.ios.map(&:freq).sum

  end

  def tags
  	@topictags=Topictag.order_by([:freq,:desc]).paginate(:page=>params[:page],:per_page=>5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topictags,:except=>[:_id] }
      format.xml { render xml: @topictags,:except=>[:_id]}
    end
    
  end


  def statistics
  	@topickeys=Topickey.order_by([:freq, :desc]).limit(20)
  	@topictags=Topictag.order_by([:freq, :desc]).limit(60)
  end
  
  def import
  	Topickey.async_scrape
  	Topictag.async_scrape
  	flash[:notice]="The job has been added to the queue"
  	redirect_to import_path
  end

  def dropdb
  	Topickey.destroy_all
  	Topictag.destroy_all
  	flash[:notice]="The Topics DB was destroyed"
  	redirect_to import_path
  end


end
