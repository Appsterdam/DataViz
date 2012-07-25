class GitusersController < ApplicationController
  # GET /gitusers
  # GET /gitusers.json
  def index
    @gitusers = Gituser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gitusers }
    end
  end

  # GET /gitusers/1
  # GET /gitusers/1.json
  def show
    @gituser = Gituser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gituser }
    end
  end

  # GET /gitusers/new
  # GET /gitusers/new.json
  def new
    @gituser = Gituser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gituser }
    end
  end

  # GET /gitusers/1/edit
  def edit
    @gituser = Gituser.find(params[:id])
  end

  # POST /gitusers
  # POST /gitusers.json
  def create
    @gituser = Gituser.new(params[:gituser])

    respond_to do |format|
      if @gituser.save
        format.html { redirect_to @gituser, notice: 'Gituser was successfully created.' }
        format.json { render json: @gituser, status: :created, location: @gituser }
      else
        format.html { render action: "new" }
        format.json { render json: @gituser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gitusers/1
  # PUT /gitusers/1.json
  def update
    @gituser = Gituser.find(params[:id])

    respond_to do |format|
      if @gituser.update_attributes(params[:gituser])
        format.html { redirect_to @gituser, notice: 'Gituser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gituser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gitusers/1
  # DELETE /gitusers/1.json
  def destroy
    @gituser = Gituser.find(params[:id])
    @gituser.destroy

    respond_to do |format|
      format.html { redirect_to gitusers_url }
      format.json { head :no_content }
    end
  end
end
