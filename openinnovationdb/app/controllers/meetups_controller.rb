class MeetupsController < ApplicationController
	
  def from_meetup
    Rawmember.async_scrape
    Member.async_scrape
   # Topickey.async_scrape
    #Importer.meetupsave
    redirect_to import_path

  end

  def importer

    @cols=Meetup.db_collections.map{|a| [a.capitalize,a]}

  end

  def import_groups
    if Resque.size("member") == 0
    Rawgroup.async_scrape
    Group.async_scrape
    Group.async_relation
    Member.async_relation
    redirect_to import_path
    end
  end

  def connect_groups_and_members
    Group.async_relation
    Member.async_relation
    flash[:notice]="Resque worker is doing this now!"
    redirect_to import_path
  end

  def dropdb
    Meetup.dropdb
   # Membersa.destroy_all
    flash[:alert] = "MemberDB destroyed"
    redirect_to import_path
  end

  def drop_groupdb
    Rawgroup.destroy_all
    flash[:alert]='Group DB was destroyed'
    redirect_to import_path
  end

end
