class LnkdinsController < ApplicationController
  # GET /lnkdins
  # GET /lnkdins.json
  def index
    @lnkdins = Lnkdin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lnkdins }
    end
  end

  # GET /lnkdins/1
  # GET /lnkdins/1.json
  def show
    @lnkdin = Lnkdin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lnkdin }
    end
  end

  # GET /lnkdins/new
  # GET /lnkdins/new.json
  def new
    @lnkdin = Lnkdin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lnkdin }
    end
  end

  # GET /lnkdins/1/edit
  def edit
    @lnkdin = Lnkdin.find(params[:id])
  end

  # POST /lnkdins
  # POST /lnkdins.json
  def create
    @lnkdin = Lnkdin.new(params[:lnkdin])

    respond_to do |format|
      if @lnkdin.save
        format.html { redirect_to @lnkdin, notice: 'Lnkdin was successfully created.' }
        format.json { render json: @lnkdin, status: :created, location: @lnkdin }
      else
        format.html { render action: "new" }
        format.json { render json: @lnkdin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lnkdins/1
  # PUT /lnkdins/1.json
  def update
    @lnkdin = Lnkdin.find(params[:id])

    respond_to do |format|
      if @lnkdin.update_attributes(params[:lnkdin])
        format.html { redirect_to @lnkdin, notice: 'Lnkdin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lnkdin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lnkdins/1
  # DELETE /lnkdins/1.json
  def destroy
    @lnkdin = Lnkdin.find(params[:id])
    @lnkdin.destroy

    respond_to do |format|
      format.html { redirect_to lnkdins_url }
      format.json { head :no_content }
    end
  end
end
