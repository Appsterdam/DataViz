class MembersasController < ApplicationController
  def index
    @members=Membersa.all

  end

  def show
  end
end
