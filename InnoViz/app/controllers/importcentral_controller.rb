class ImportcentralController < ApplicationController
  def index
    @member_count = Meetup.count_members
    @remaining = Meetup.remaining_rate
  end
end
