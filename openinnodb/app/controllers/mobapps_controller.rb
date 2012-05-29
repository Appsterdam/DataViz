class MobappsController < ApplicationController
  # GET /mobapps
  # GET /mobapps.json
  def index
    @mobapps = Mobapp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mobapps }
    end
  end

  # GET /mobapps/1
  # GET /mobapps/1.json
  def show
    @mobapp = Mobapp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mobapp }
    end
  end

  # GET /mobapps/new
  # GET /mobapps/new.json
  def new
    @mobapp = Mobapp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mobapp }
    end
  end

  # GET /mobapps/1/edit
  def edit
    @mobapp = Mobapp.find(params[:id])
  end

  # POST /mobapps
  # POST /mobapps.json
  def create
    @mobapp = Mobapp.new(params[:mobapp])

    respond_to do |format|
      if @mobapp.save
        format.html { redirect_to @mobapp, notice: 'Mobapp was successfully created.' }
        format.json { render json: @mobapp, status: :created, location: @mobapp }
      else
        format.html { render action: "new" }
        format.json { render json: @mobapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mobapps/1
  # PUT /mobapps/1.json
  def update
    @mobapp = Mobapp.find(params[:id])

    respond_to do |format|
      if @mobapp.update_attributes(params[:mobapp])
        format.html { redirect_to @mobapp, notice: 'Mobapp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mobapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobapps/1
  # DELETE /mobapps/1.json
  def destroy
    @mobapp = Mobapp.find(params[:id])
    @mobapp.destroy

    respond_to do |format|
      format.html { redirect_to mobapps_url }
      format.json { head :no_content }
    end
  end
end
