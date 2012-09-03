class TopickeysController < ApplicationController
  # GET /topickeys
  # GET /topickeys.json
  def index
    @topickeys = Topickey.all.desc(:freq).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topickeys }
    end
  end

  # GET /topickeys/1
  # GET /topickeys/1.json
  def show
    @topickey = Topickey.find(params[:id])
    @members = Member.where("topics.topic_id"=>@topickey.topic_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topickey }
    end
  end

  def filtered
    @android_titles=Topickey.android.map(&:name)
    @ios_titles=Topickey.ios.map(&:name)
    @android_sum=Topickey.android.map(&:freq).sum
    @ios_sum=Topickey.ios.map(&:freq).sum
    @bb_titles=Topickey.blackberry.map(&:name)
    @bb_sum=Topickey.blackberry.map(&:freq).sum
    @windows_titles=Topickey.windows.map(&:name)
    @windows_sum=Topickey.windows.map(&:freq).sum

  end

  def tags
    @topictags=Topictag.normalized.desc(:freq).page(params[:page])#paginate(:page=>params[:page],:per_page=>5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topictags,:except=>[:_id] }
      format.xml { render xml: @topictags,:except=>[:_id]}
    end

  end

  # GET /topickeys/new
  # GET /topickeys/new.json
  def new
    @topickey = Topickey.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topickey }
    end
  end

  # GET /topickeys/1/edit
  def edit
    @topickey = Topickey.find(params[:id])
  end

  # POST /topickeys
  # POST /topickeys.json
  def create
    @topickey = Topickey.new(params[:topickey])

    respond_to do |format|
      if @topickey.save
        format.html { redirect_to @topickey, notice: 'Topickey was successfully created.' }
        format.json { render json: @topickey, status: :created, location: @topickey }
      else
        format.html { render action: "new" }
        format.json { render json: @topickey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topickeys/1
  # PUT /topickeys/1.json
  def update
    @topickey = Topickey.find(params[:id])

    respond_to do |format|
      if @topickey.update_attributes(params[:topickey])
        format.html { redirect_to @topickey, notice: 'Topickey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topickey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topickeys/1
  # DELETE /topickeys/1.json
  def destroy
    @topickey = Topickey.find(params[:id])
    @topickey.destroy

    respond_to do |format|
      format.html { redirect_to topickeys_url }
      format.json { head :no_content }
    end
  end
end
