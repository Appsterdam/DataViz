module ApplicationHelper

  def todate(who)
    Time.at(who/1000)
  end
end
