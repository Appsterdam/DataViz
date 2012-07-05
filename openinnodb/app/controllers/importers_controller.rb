class ImportersController < ApplicationController
  def frommeetup
    Member.async_scrape
    Membersa.async_scrape
    Topickey.async_scrape
    #Importer.meetupsave
    redirect_to import_path

  end

  # GET /importers
  # GET /importers.json
  #  def index
  #    @importers = Importer.all
  #
  #    respond_to do |format|
  #      format.html # index.html.erb
  #      format.json { render json: @importers }
  #    end
  #  end
  #
  #  # GET /importers/1
  #  # GET /importers/1.json
  #  def show
  #    @importer = Importer.find(params[:id])
  #
  #    respond_to do |format|
  #      format.html # show.html.erb
  #      format.json { render json: @importer }
  #    end
  #  end
  #
  #  # GET /importers/new
  #  # GET /importers/new.json
  #  def new
  #    @importer = Importer.new
  #
  #    respond_to do |format|
  #      format.html # new.html.erb
  #      format.json { render json: @importer }
  #    end
  #  end
  #
  #  # GET /importers/1/edit
  #  def edit
  #    @importer = Importer.find(params[:id])
  #  end
  #
  #  # POST /importers
  #  # POST /importers.json
  #  def create
  #    @importer = Importer.new(params[:importer])
  #
  #    respond_to do |format|
  #      if @importer.save
  #        format.html { redirect_to @importer, notice: 'Importer was successfully created.' }
  #        format.json { render json: @importer, status: :created, location: @importer }
  #      else
  #        format.html { render action: "new" }
  #        format.json { render json: @importer.errors, status: :unprocessable_entity }
  #      end
  #    end
  #  end
  #
  #  # PUT /importers/1
  #  # PUT /importers/1.json
  #  def update
  #    @importer = Importer.find(params[:id])
  #
  #    respond_to do |format|
  #      if @importer.update_attributes(params[:importer])
  #        format.html { redirect_to @importer, notice: 'Importer was successfully updated.' }
  #        format.json { head :no_content }
  #      else
  #        format.html { render action: "edit" }
  #        format.json { render json: @importer.errors, status: :unprocessable_entity }
  #      end
  #    end
  #  end
  #
  #  # DELETE /importers/1
  #  # DELETE /importers/1.json
  #  def destroy
  #    @importer = Importer.find(params[:id])
  #    @importer.destroy
  #
  #    respond_to do |format|
  #      format.html { redirect_to importers_url }
  #      format.json { head :no_content }
  #    end
  #  end




  def importer

    @cols=Importer.db_collections.map{|a| [a.capitalize,a]}

  end
  def importgroups
    if Resque.size("member") == 0
    Groupraw.async_scrape
    Groupsa.async_scrape
    Groupsa.async_relation
    Membersa.async_relation
    redirect_to import_path
    end
  end

  def connectgroupsandmembers
    Groupsa.async_relation
    Membersa.async_relation
    flash[:notice]="Resque worker is doing this now!"
    redirect_to import_path
  end

  def dropdb
    Importer.dropdb
    Membersa.dropdb
    flash[:notice] = "MemberDB dropped"
    redirect_to import_path
  end

  def dropgroupdb
    Groupraw.destroy_all
    flash[:notice]='Group DB was erased'
    redirect_to import_path
  end

end
